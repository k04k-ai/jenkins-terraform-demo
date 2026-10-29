import os
import socket
from fastapi import FastAPI

app = FastAPI(title="CI/CD Demo")


@app.get("/")
def home():
    return {
        "message": "Hello from my app deployed by a Jenkins pipeline!",
        "host_name": socket.gethostname(),
        "version": os.getenv("APP_VERSION", "dev"),
    }


@app.get("/health")
def health():
    return {"status": "ok"}
