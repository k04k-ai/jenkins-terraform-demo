import os
import socket
from fastapi import FastAPI

app = FastAPI(title="CI/CD Demo")


@app.get("/")
def home():
    return {
        "message": "Hope you are doing well, from Jenkins!",
        "host_name": socket.gethostname(),
        "version": os.getenv("APP_VERSION", "dev"),
    }


@app.get("/health")
def health():
    return {"status": "ok"}
