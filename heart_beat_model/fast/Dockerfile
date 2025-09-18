FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install build tools
RUN pip install --upgrade pip setuptools wheel

# Set working directory
WORKDIR /app

# Copy requirements from parent directory
COPY requirements_minimal.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements_minimal.txt

# Copy the entire heart_beat_model directory for access to models/data
COPY fast ./fast
COPY scripts ./scripts
COPY mlflow ./mlflow
COPY datasets ./datasets

# Set working directory to fast folder
WORKDIR /app/fast

# Expose FastAPI port
EXPOSE 8000

# Command to run FastAPI
CMD ["uvicorn", "stress_model:app", "--host", "0.0.0.0", "--port", "8000"]