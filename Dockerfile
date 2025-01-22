# Use the official Python base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install dependencies from requirements.txt
RUN pip install -r requirements.txt

# Copy the app code into the container
COPY app.py .

# Expose the port the app will run on
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]
