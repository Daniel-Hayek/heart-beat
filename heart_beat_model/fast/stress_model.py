from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
import mlflow.pyfunc

app = FastAPI()

class StressInput(BaseModel):
    sleep_duration: float
    physical_activity_level: float
    heart_rate: float
    daily_steps: float

mlflow.set_tracking_uri("http://localhost:5000")
model = mlflow.pyfunc.load_model(modelPath)

@app.get("/")
def root():
    return {"message": "Stress prediction API is running"}

@app.get("/predict_stress")
def predict_stress(data: StressInput):
    df = pd.DataFrame([{
        "Sleep Duration": data.sleep_duration,
        "Physical Activity Level": data.physical_activity_level,
        "Heart Rate": data.heart_rate,
        "Daily Steps": data.daily_steps,
    }])

    prediction = model.predict(df)[0]

    return {"predicted_stress" : int(prediction)}