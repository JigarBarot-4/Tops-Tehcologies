import pandas as pd
import joblib

from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import StandardScaler

# Dummy Dataset
data = {
    "tempo":[120,125,130,140,150,145,70,75,80,118,135,72,122,148,78],
    "energy":[0.85,0.80,0.78,0.95,0.98,0.92,0.20,0.25,0.30,0.82,0.90,0.22,0.84,0.96,0.28],
    "danceability":[0.90,0.88,0.85,0.75,0.70,0.72,0.30,0.35,0.40,0.87,0.78,0.32,0.89,0.68,0.38],
    "genre":["Pop","Pop","Pop","Rock","Rock","Rock",
             "Classical","Classical","Classical",
             "Pop","Rock","Classical","Pop","Rock","Classical"]
}

df = pd.DataFrame(data)

X = df[["tempo","energy","danceability"]]
y = df["genre"]

# Scale Data
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Train/Test Split
X_train, X_test, y_train, y_test = train_test_split(
    X_scaled, y, test_size=0.2, random_state=42
)

# Train Model
model = RandomForestClassifier(n_estimators=100)
model.fit(X_train, y_train)

# Save Model and Scaler
joblib.dump(model, "music_genre_model.pkl")
joblib.dump(scaler, "scaler.pkl")

print("Model Saved Successfully!")