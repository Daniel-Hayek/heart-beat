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

n_samples = 20000

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
perturb_factor = 0.02
rng = np.random.default_rng(seed=42)

cov_perturbed = cov + rng.normal(0, perturb_factor, cov.shape)
cov_perturbed = (cov_perturbed + cov_perturbed.T) / 2

# --- Step 5: Generate synthetic Gaussian samples ---
synthetic_gauss = rng.multivariate_normal(
    mean=np.zeros(len(features)),
    cov=cov_perturbed,
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
counts = df[STRESS_LEVEL].value_counts()
rare_classes = counts[counts < 50].index
oversampled_df = df.copy()
for cls in rare_classes:
    n_needed = 50 - counts[cls]
    extra_samples = df[df[STRESS_LEVEL] == cls].sample(n=n_needed, replace=True)
    oversampled_df = pd.concat([oversampled_df, extra_samples], ignore_index=True)

# --- Step 10: Conditional Stress Level using Random Forest ---
X_real = oversampled_df[cont_features]
y_real = oversampled_df[STRESS_LEVEL]

rf = RandomForestRegressor(n_estimators=200, max_depth=8, random_state=42, min_samples_leaf=1, max_features=1.0)
rf.fit(X_real, y_real)

synthetic_stress = rf.predict(synthetic_df[cont_features])

# --- Step 11: Add slight Gaussian noise to continuous features ---
for col in cont_features:
    noise = rng.normal(0, 0.05 * df[col].std(), n_samples)
    synthetic_df[col] += noise

# Re-clip
synthetic_df[SLEEP_DURATION] = synthetic_df[SLEEP_DURATION].clip(3, 12)
synthetic_df[PHYSICAL_ACTIVITY] = synthetic_df[PHYSICAL_ACTIVITY].clip(0, 300)
synthetic_df[HEART_RATE] = synthetic_df[HEART_RATE].clip(40, 120)
synthetic_df[DAILY_STEPS] = synthetic_df[DAILY_STEPS].clip(0, 30000)

# --- Step 12: Clip Stress Level to 1-10 integers ---
synthetic_stress = np.clip(synthetic_stress, 1, 10)
synthetic_df[STRESS_LEVEL] = np.round(synthetic_stress).astype(int)

# Save synthetic dataset
synthetic_df.to_csv("synthetic_sleep_stress_dataset_final.csv", index=False)
print("Final synthetic dataset saved with shape:", synthetic_df.shape)
