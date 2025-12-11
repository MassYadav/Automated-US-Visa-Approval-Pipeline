FROM python:3.8.5-slim-buster

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

# Expose port for Kubernetes / Docker
EXPOSE 8080

# Run FastAPI using Uvicorn (much better than python app.py)
# IMPORTANT: we point to `app:app` because your FastAPI object is named `app` inside app.py
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]
