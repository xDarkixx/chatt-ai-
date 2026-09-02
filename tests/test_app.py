from fastapi.testclient import TestClient
from backend.main import app

client = TestClient(app)

def test_health():
    r = client.get('/api/health')
    assert r.status_code == 200
    assert r.json()['status'] == 'ok'

def test_chat_demo():
    r = client.post('/api/chat', json={'messages':[{'role':'user','content':'Hallo'}]})
    assert r.status_code == 200
    assert r.json()['message']['role'] == 'assistant'
    assert 'Hallo' in r.json()['message']['content']

def test_frontend():
    r = client.get('/')
    assert r.status_code == 200
    assert 'MY-PRIVATE-AI' in r.text
