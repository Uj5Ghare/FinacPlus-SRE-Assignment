# Step 1: Build Stage - Use an official Python 3.12 image for building dependencies
FROM python:3.12-slim AS build

# Set a working directory for the build stage
WORKDIR /app

# Copy the requirements file into the container (this is needed to install dependencies)
COPY requirements.txt .

# Install Python dependencies in the build stage
RUN pip install --no-cache-dir -r requirements.txt


# Step 2: Runtime Stage - Use a smaller image for the final application
FROM python:3.12-alpine AS runtime

# Set a working directory for the runtime stage
WORKDIR /usr/local/app/

# Copy only the installed Python packages from the build stage
COPY --from=build /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages

# Copy the application code into the container
COPY . .

# Expose the port that Flask will run on
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_ENV=production

# Command to run the Flask application
CMD ["python","app.py"]

