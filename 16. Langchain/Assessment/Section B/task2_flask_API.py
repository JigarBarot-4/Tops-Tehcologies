from flask import Flask, request, jsonify
import joblib
import pandas as pd

app = Flask(__name__)

# Load model only once
model = joblib.load("delivery_model.joblib")


@app.route("/")
def home():
    return "Delivery Time Prediction API is Running"


@app.route("/predict", methods=["POST"])
def predict():

    data = request.get_json()

    # Check if data is received
    if data is None:
        return jsonify({"error": "No JSON data received"}), 400

    # Check required fields
    if "distance_km" not in data:
        return jsonify({"error": "distance_km is missing"}), 400

    if "num_items" not in data:
        return jsonify({"error": "num_items is missing"}), 400

    if "rain_flag" not in data:
        return jsonify({"error": "rain_flag is missing"}), 400

    # Prepare input
    sample = pd.DataFrame({
        "distance_km": [data["distance_km"]],
        "num_items": [data["num_items"]],
        "rain_flag": [data["rain_flag"]]
    })

    # Predict
    prediction = model.predict(sample)

    # Return result
    return jsonify({
        "predicted_delivery_time_min": round(float(prediction[0]), 1)
    }), 200


if __name__ == "__main__":
    app.run(debug=False)