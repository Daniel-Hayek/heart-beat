FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy requirements from parent directory
COPY ../requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire heart_beat_model directory for access to models/data
COPY .. .

# Set working directory to fast folder
WORKDIR /app/fast

# Expose FastAPI port
EXPOSE 8000

# Command to run FastAPI
CMD ["uvicorn", "stress_model:app", "--host", "0.0.0.0", "--port", "8000"]