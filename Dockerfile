FROM python:3.9-alpine

USER root

WORKDIR /app

COPY requirements.txt /app

# Install dependencies
RUN apk update && \
    apk add --no-cache libexpat gcc musl-dev libffi-dev && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install -U psutil && \
    pip install -U aiohttp==3.9.0rc0

# Make sure the entire project directory is copied
COPY . /app

# Ensure that app.py and other files have correct permissions
RUN chmod -R 755 /app

# Set environment variables for Flask
ENV FLASK_APP=app.py
ENV FLASK_ENV=development

# Expose the port Flask will run on (default is 5001)
EXPOSE 5001

# Run Flask in development mode
CMD ["flask", "run", "--host=0.0.0.0", "--port=5001"]
