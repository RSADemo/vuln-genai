# Use the latest Python image
#FROM python:3.11-alpine
FROM cgr.dev/chainguard/python:latest-dev
USER root
# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt /app

# Update apt repositories, install packages, upgrade pip, and install requirements from requirements.txt
# Also install psutil and a specific version of aiohttp
RUN apk update && \
    apk add --no-cache libexpat1=2.6.2-r0 && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install -U psutil && \
    pip install -U aiohttp==3.9.0rc0
    
# Clean up the apk cache to reduce image size
RUN rm -rf /var/cache/apk/*

# Copy the entire project directory into the container at /app
COPY . /app

# Command to run on container start
CMD ["app.py"]
