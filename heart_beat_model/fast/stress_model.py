from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class StressInput(BaseModel):
    sleep_duration: float
    physical_activity_level: float
    heart_rate: float
    daily_steps: float

modelPath = "../mlflow_tracking/artifacts/339102042405170477/models/m-2fce512dcc0b4006ad32df59ddf9d556/artifacts"

@app.get("/")
def root():
    return {"message": "Stress prediction API is running"}