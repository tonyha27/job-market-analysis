# LAST MODIFIED: 9/11/2026

FROM python:slim

WORKDIR /app

# 1. Install system dependencies, Chromium and matching ChromeDriver.
RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    curl \
    ca-certificates \
    build-essential \
    unixodbc-dev \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# 3. Add Microsoft's repository for the installed Debian version.
RUN . /etc/os-release \
    && curl -fsSL \
    "https://packages.microsoft.com/config/debian/${VERSION_ID}/packages-microsoft-prod.deb" \
    -o /tmp/packages-microsoft-prod.deb \
    && dpkg -i /tmp/packages-microsoft-prod.deb \
    && rm /tmp/packages-microsoft-prod.deb

# 4. Install Microsoft ODBC Driver 18
RUN apt-get update \
    && ACCEPT_EULA=Y apt-get install -y \
    --no-install-recommends \
    msodbcsql18 \
    && rm -rf /var/lib/apt/lists/*

# 5. Install Python dependencies
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy Python source code
COPY python/main.py python/scraper.py python/database.py ./

# 7. Run scraper when container starts
CMD ["python", "-u", "main.py"]