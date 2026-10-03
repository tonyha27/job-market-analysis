FROM python:3.14.7-slim

# Install Chromium and ChromeDriver
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY scraper.py .

CMD ["sh", "-c", "gunicorn --timeout 3900 --bind 0.0.0.0:$PORT app:app"]