import streamlit as st
import pandas as pd
import joblib

# Load model
model = joblib.load("music_genre_model.pkl")

# Load scaler if used during training
# scaler = joblib.load("scaler.pkl")

st.title("🎵 Music Genre Prediction")

uploaded_file = st.file_uploader(
    "Upload CSV File",
    type=["csv"]
)

if uploaded_file is not None:

    # Read CSV
    df = pd.read_csv(uploaded_file)

    st.subheader("Uploaded Data")
    st.dataframe(df)

    # Apply preprocessing if used during training
    # df_scaled = scaler.transform(df)

    # Predict genres
    predictions = model.predict(df)

    # Add predictions to table
    result_df = df.copy()
    result_df["Predicted_Genre"] = predictions

    st.subheader("Prediction Results")
    st.dataframe(result_df)

    # Download predictions
    csv = result_df.to_csv(index=False).encode("utf-8")

    st.download_button(
        "Download Predictions",
        csv,
        "genre_predictions.csv",
        "text/csv"
    )