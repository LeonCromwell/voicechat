
FROM python:3.11-slim

WORKDIR /app


RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    espeak-ng \
    ffmpeg \
    libopus0 \
    libopus-dev \
    byobu \
    curl \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


COPY . .

RUN groupadd -g 1000 app_group && \
    useradd -g app_group --uid 1000 app_user && \
    chown -R app_user:app_group /app

USER app_user

EXPOSE 8004
EXPOSE 8005
EXPOSE 8006


# CMD ["uvicorn", "src.app:app", "--host", "0.0.0.0", "--port", "5000"]
