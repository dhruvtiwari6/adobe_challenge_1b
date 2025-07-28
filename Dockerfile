# Use a lightweight base image with amd64 compatibility
FROM --platform=linux/amd64 python:3.10-slim

# Set working directory inside the container
WORKDIR /app

# Copy only requirements.txt first for caching layer efficiency
COPY requirements.txt .

# Install dependencies (no internet access allowed at runtime, only build-time)
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the codebase (including test.py, input/, output/)
COPY . .

# Ensure input/output directories exist (for safety)
RUN mkdir -p /app/input /app/output

# Set the default command to run your script
CMD ["python", "main.py"]

