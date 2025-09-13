import pandas as pd
import numpy as np
from scipy.stats import rankdata, norm
from sklearn.ensemble import RandomForestRegressor

# --- Column name constants ---
SLEEP_DURATION = "Sleep Duration"
PHYSICAL_ACTIVITY = "Physical Activity Level"
HEART_RATE = "Heart Rate"
DAILY_STEPS = "Daily Steps"
STRESS_LEVEL = "Stress Level"

features = [SLEEP_DURATION, PHYSICAL_ACTIVITY, HEART_RATE, DAILY_STEPS, STRESS_LEVEL]
cont_features = [SLEEP_DURATION, PHYSICAL_ACTIVITY, HEART_RATE, DAILY_STEPS]

df = pd.read_csv("../datasets/Sleep_health_and_lifestyle_dataset.csv")
df = df[features]

n_samples = 40000

# --- Step 1: Convert features to uniform marginals using rank transformation ---
uniform_df = df.copy()
for col in features:
    ranks = rankdata(df[col], method='average')
    uniform_df[col] = (ranks - 1) / (len(df) - 1)

# --- Step 2: Map uniform marginals to Gaussian space ---
gauss_df = norm.ppf(uniform_df.clip(1e-6, 1 - 1e-6))

# --- Step 3: Estimate covariance matrix ---
cov = np.cov(gauss_df.T)

# --- Step 4: Perturb covariance slightly to increase diversity ---
perturb_factor = 0.05
rng = np.random.default_rng(seed=42)

cov_perturbed = cov + rng.normal(0, perturb_factor, cov.shape)
cov_perturbed = (cov_perturbed + cov_perturbed.T) / 2

# --- Step 5: Generate synthetic Gaussian samples ---
mean_perturb = rng.normal(0, 0.2, len(features))
scale_factor = 1.5
eigvals, eigvecs = np.linalg.eigh(cov_perturbed)
eigvals[eigvals < 1e-6] = 1e-6  # tiny positive eigenvalues
cov_perturbed_psd = eigvecs @ np.diag(eigvals) @ eigvecs.T

synthetic_gauss = rng.multivariate_normal(
    mean=mean_perturb,
    cov=cov_perturbed_psd * scale_factor,
    size=n_samples
)

# --- Step 6: Map back to uniform ---
synthetic_uniform = norm.cdf(synthetic_gauss)

# --- Step 7: Map to original feature distributions ---
synthetic_df = pd.DataFrame()
for i, col in enumerate(features):
    sorted_vals = np.sort(df[col].values)
    synthetic_df[col] = np.interp(synthetic_uniform[:, i], np.linspace(0, 1, len(sorted_vals)), sorted_vals)

# --- Step 8: Clip continuous features ---
synthetic_df[SLEEP_DURATION] = synthetic_df[SLEEP_DURATION].clip(3, 12)
synthetic_df[PHYSICAL_ACTIVITY] = synthetic_df[PHYSICAL_ACTIVITY].clip(0, 300)
synthetic_df[HEART_RATE] = synthetic_df[HEART_RATE].clip(40, 120)
synthetic_df[DAILY_STEPS] = synthetic_df[DAILY_STEPS].clip(0, 30000)

# --- Step 9: Oversample rare classes ---
threshold = 100
counts = df[STRESS_LEVEL].value_counts()
rare_classes = counts[counts < threshold].index
oversampled_df = df.copy()
for cls in rare_classes:
    rare_samples = df[df[STRESS_LEVEL] == cls]
    n_needed = threshold - len(rare_samples)
    noise = rng.normal(0, 0.05 * rare_samples[cont_features].std(), (n_needed, len(cont_features)))
    new_samples = rare_samples.sample(n=n_needed, replace=True).reset_index(drop=True)
    new_samples[cont_features] += noise
    oversampled_df = pd.concat([oversampled_df, new_samples], ignore_index=True)

# --- Step 10: Conditional Stress Level using Random Forest ---
X_real = oversampled_df[cont_features]
y_real = oversampled_df[STRESS_LEVEL]

rf = RandomForestRegressor(n_estimators=200, max_depth=8, random_state=42, min_samples_leaf=1, max_features=1.0)
rf.fit(X_real, y_real)

n_extreme = 300

# --- Generate extreme high cases ---
extreme_high = pd.DataFrame({
    SLEEP_DURATION: rng.uniform(3, 5, n_extreme),  # low sleep
    PHYSICAL_ACTIVITY: rng.uniform(200, 300, n_extreme),  # high activity
    HEART_RATE: rng.uniform(100, 120, n_extreme),
    DAILY_STEPS: rng.uniform(15000, 30000, n_extreme)
})
extreme_high[STRESS_LEVEL] = rf.predict(extreme_high[cont_features])
synthetic_df = pd.concat([synthetic_df, extreme_high], ignore_index=True)

# --- Generate extreme low cases (more samples than before) ---
n_extreme_low = 800  # increased number of low extremes
extreme_low = pd.DataFrame({
    SLEEP_DURATION: rng.uniform(10, 12, n_extreme_low),  # long sleep
    PHYSICAL_ACTIVITY: rng.uniform(0, 50, n_extreme_low),  # low activity
    HEART_RATE: rng.uniform(40, 60, n_extreme_low),       # low heart rate
    DAILY_STEPS: rng.uniform(0, 5000, n_extreme_low)      # low steps
})
extreme_low[STRESS_LEVEL] = rf.predict(extreme_low[cont_features])
synthetic_df = pd.concat([synthetic_df, extreme_low], ignore_index=True)

# Predict stress for main synthetic data
synthetic_df[STRESS_LEVEL] = rf.predict(synthetic_df[cont_features]).round().astype(int)

# --- Step 11: Add slight Gaussian noise to continuous features ---
for col in cont_features:
    noise = rng.normal(0, 0.05 * df[col].std(), size=synthetic_df.shape[0])
    synthetic_df[col] += noise

# Re-clip
synthetic_df[SLEEP_DURATION] = synthetic_df[SLEEP_DURATION].clip(0, 14)
synthetic_df[PHYSICAL_ACTIVITY] = synthetic_df[PHYSICAL_ACTIVITY].clip(0, 300)
synthetic_df[HEART_RATE] = synthetic_df[HEART_RATE].clip(40, 140)
synthetic_df[DAILY_STEPS] = synthetic_df[DAILY_STEPS].clip(0, 35000)

# --- Step 13: Targeted exploration (extreme/unseen combinations) ---
extreme_samples = pd.DataFrame({
    SLEEP_DURATION: rng.uniform(2, 14, 500),          # wider sleep duration
    PHYSICAL_ACTIVITY: rng.uniform(0, 350, 500),     # higher activity
    HEART_RATE: rng.uniform(40, 120, 500),           # plausible HR range
    DAILY_STEPS: rng.uniform(0, 40000, 500),         # higher steps
})
extreme_samples[STRESS_LEVEL] = rf.predict(extreme_samples[cont_features]).round().astype(int)
synthetic_df = pd.concat([synthetic_df, extreme_samples], ignore_index=True)

# --- Step 14: Save final dataset ---
synthetic_df.to_csv("../datasets/synthetic_sleep_stress_dataset_final.csv", index=False)
print("Final synthetic dataset saved with shape:", synthetic_df.shape)
