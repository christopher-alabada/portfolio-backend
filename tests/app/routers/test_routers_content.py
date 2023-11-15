from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)


def test_intro():
    response = client.get("/content/intro")
    assert response.status_code == 200
    assert "title" in response.json()
    assert "body" in response.json()


def test_toolbox():
    response = client.get("/content/toolbox")
    assert response.status_code == 200
    assert "languages" in response.json()
    assert "frameworks" in response.json()
    assert "databases" in response.json()
    assert "miscellaneous" in response.json()


def test_experiences():
    response = client.get("/content/experiences")
    assert response.status_code == 200
    assert isinstance(response.json(), list)


def test_projects():
    response = client.get("/content/projects")
    assert response.status_code == 200
    assert isinstance(response.json(), list)


def test_all_content():
    response = client.get("/content")
    assert response.status_code == 200
    assert "intro" in response.json()
    assert "toolbox" in response.json()
    assert "experience" in response.json()
    assert "projects" in response.json()
