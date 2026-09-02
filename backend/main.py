import os
from typing import Literal
import httpx
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel

app = FastAPI(title="MY-PRIVATE-AI", version="1.0.0")

class Message(BaseModel):
    role: Literal["user", "assistant", "system"]
    content: str

class ChatRequest(BaseModel):
    messages: list[Message]

class ChatResponse(BaseModel):
    message: Message

def demo_reply(messages: list[Message]) -> str:
    user = next((m.content for m in reversed(messages) if m.role == "user"), "")
    return f"Demo-KI: Du hast geschrieben: {user}"

async def ollama_reply(messages: list[Message]) -> str:
    base = os.getenv("OLLAMA_BASE_URL", "http://127.0.0.1:11434").rstrip("/")
    model = os.getenv("OLLAMA_MODEL", "llama3.2")
    payload = {"model": model, "messages": [m.model_dump() for m in messages], "stream": False}
    async with httpx.AsyncClient(timeout=120) as client:
        r = await client.post(f"{base}/api/chat", json=payload)
        r.raise_for_status()
        data = r.json()
    return data["message"]["content"]

@app.get("/api/health")
async def health():
    return {"status": "ok", "provider": os.getenv("AI_PROVIDER", "demo")}

@app.post("/api/chat", response_model=ChatResponse)
async def chat(req: ChatRequest):
    provider = os.getenv("AI_PROVIDER", "demo").lower()
    answer = await ollama_reply(req.messages) if provider == "ollama" else demo_reply(req.messages)
    return ChatResponse(message=Message(role="assistant", content=answer))

app.mount("/", StaticFiles(directory="frontend", html=True), name="frontend")
