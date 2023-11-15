from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)


def test_not_found_handler():
    response = client.get("/not/found/path")
    assert response.status_code == 404
    assert response.json() == {"error": {"code": 404, "message": "Not found"}}
