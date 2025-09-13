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

# Copy the entire heart_beat_model directory
COPY . .

# Set working directory to mlflow folder (to match your local setup)
WORKDIR /app/mlflow

# Create mlflow directory and set permissions if needed
RUN mkdir -p . && chmod 755 .

# Expose MLflow port
EXPOSE 5000

# Command to run MLflow server from within mlflow directory
# This matches your local: mlflow server --host 127.0.0.1 --port 5000
CMD ["mlflow", "server", "--host", "0.0.0.0", "--port", "5000"]