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

# Copy requirements file
COPY requirements_minimal.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements_minimal.txt

# Copy the entire heart_beat_model directory
COPY . .

# Create mlflow directory if it doesn't exist
RUN mkdir -p mlflow

# Expose ports for both FastAPI and MLflow
EXPOSE 8000 5000

# Default command (can be overridden in docker-compose)
CMD ["python", "-c", "print('Base image ready')"]