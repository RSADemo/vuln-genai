#FROM python:slim
FROM python:3.9-alpine

USER root

WORKDIR /app

COPY requirements.txt /app

# Install Python packages specified in requirements.txt
# and additional package psutil
RUN apk update && \
    apk add --no-cache libexpat gcc musl-dev libffi-dev && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install -U psutil && \
    pip install -U aiohttp==3.9.0rc0

# Make sure the entire project directory is copied
COPY . /app

CMD ["python", "app.py"]
