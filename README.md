# MY-PRIVATE-AI

Self-hosted ChatGPT-style web app with a FastAPI backend and a pluggable model provider.

## Quick start

```bash
python -m venv .venv
# Linux/macOS: source .venv/bin/activate
pip install -r requirements.txt
uvicorn backend.main:app --reload
```

Open http://127.0.0.1:8000

The default provider is a deterministic local demo provider, so the project works without an API key. Set `AI_PROVIDER=ollama` and `OLLAMA_MODEL=<model>` to connect an Ollama-compatible local model.

## Tests

```bash
pytest -q
```
