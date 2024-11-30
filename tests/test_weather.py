import pytest
from app.weather import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_should_status_code_ok(client):
    response = client.get('/')
    assert response.status_code == 200