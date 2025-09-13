FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy requirements from parent directory
COPY ../requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire heart_beat_model directory
COPY .. .

# Create mlflow directory and set permissions
RUN mkdir -p mlflow && chmod 755 mlflow

# Expose MLflow port
EXPOSE 5000

# Command to run MLflow server
# Note: we run from /app (heart_beat_model level) to match your local setup
CMD ["mlflow", "server", "--host", "0.0.0.0", "--port", "5000", "--backend-store-uri", "file:///app/mlflow"]