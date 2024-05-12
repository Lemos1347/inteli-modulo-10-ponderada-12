# Stage 1: Build stage using a full Python image
FROM python:3.10.14 

# Set the working directory in the builder stage
WORKDIR /build

RUN apt-get update && apt-get install -y build-essential libpq-dev libffi-dev python3-dev libevent-dev

# Install dependencies in a way that they are suitable for alpine
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt 

# Copy the application code
COPY . .

# Make port 3001 available to the world outside this container
EXPOSE 3001

# Run main.py when the container launches
CMD ["python3", "main.py"]
