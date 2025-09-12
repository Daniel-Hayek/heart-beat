import pandas as pd 
import numpy as np

from scipy.stats import rankdata, norm

from sklearn.ensemble import RandomForestRegressor

df = pd.read_csv("../datasets/Sleep_health_and_lifestyle_dataset.csv")

features = ["Sleep Duration", "Physical Activity Level", "Heart Rate", "Daily Steps", "Stress Level"]
df = df[features]

cont_features = ["Sleep Duration", "Physical Activity Level", "Heart Rate", "Daily Steps"]
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
perturb_factor = 0.02  # small correlation perturbation
cov_perturbed = cov + np.random.normal(0, perturb_factor, cov.shape)
cov_perturbed = (cov_perturbed + cov_perturbed.T) / 2  # ensure symmetry

# --- Step 5: Generate synthetic Gaussian samples ---
synthetic_gauss = np.random.multivariate_normal(mean=np.zeros(len(features)), cov=cov_perturbed, size=n_samples)

# --- Step 6: Map back to uniform ---
synthetic_uniform = norm.cdf(synthetic_gauss)

# --- Step 7: Map to original feature distributions ---
synthetic_df = pd.DataFrame()
for i, col in enumerate(features):
    sorted_vals = np.sort(df[col].values)
    synthetic_df[col] = np.interp(synthetic_uniform[:, i], np.linspace(0, 1, len(sorted_vals)), sorted_vals)

# --- Step 8: Clip continuous features ---
synthetic_df["Sleep Duration"] = synthetic_df["Sleep Duration"].clip(3, 12)
synthetic_df["Physical Activity Level"] = synthetic_df["Physical Activity Level"].clip(0, 300)
synthetic_df["Heart Rate"] = synthetic_df["Heart Rate"].clip(40, 120)
synthetic_df["Daily Steps"] = synthetic_df["Daily Steps"].clip(0, 30000)

# --- Step 9: Oversample rare classes ---
counts = df["Stress Level"].value_counts()
rare_classes = counts[counts < 50].index
oversampled_df = df.copy()
for cls in rare_classes:
    n_needed = 50 - counts[cls]
    extra_samples = df[df["Stress Level"] == cls].sample(n=n_needed, replace=True)
    oversampled_df = pd.concat([oversampled_df, extra_samples], ignore_index=True)

# --- Step 10: Conditional Stress Level using Random Forest ---
X_real = oversampled_df[cont_features]
y_real = oversampled_df["Stress Level"]

rf = RandomForestRegressor(n_estimators=200, max_depth=8, random_state=42)
rf.fit(X_real, y_real)

synthetic_stress = rf.predict(synthetic_df[cont_features])

# --- Step 11: Add slight Gaussian noise to continuous features ---
for col in cont_features:
    noise = np.random.normal(0, 0.05 * df[col].std(), n_samples)
    synthetic_df[col] += noise
    # Re-clip
synthetic_df["Sleep Duration"] = synthetic_df["Sleep Duration"].clip(3, 12)
synthetic_df["Physical Activity Level"] = synthetic_df["Physical Activity Level"].clip(0, 300)
synthetic_df["Heart Rate"] = synthetic_df["Heart Rate"].clip(40, 120)
synthetic_df["Daily Steps"] = synthetic_df["Daily Steps"].clip(0, 30000)

# --- Step 12: Clip Stress Level to 1-10 integers ---
synthetic_stress = np.clip(synthetic_stress, 1, 10)
synthetic_df["Stress Level"] = np.round(synthetic_stress).astype(int)

# Save synthetic dataset
synthetic_df.to_csv("synthetic_sleep_stress_dataset_final.csv", index=False)
print("Final synthetic dataset saved with shape:", synthetic_df.shape)