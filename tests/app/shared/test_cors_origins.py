from app.shared.cors_origins import get_cors_origins


def test_get_cors_origins():
    cors = get_cors_origins()
    assert "http://127.0.0.1:3000" in cors["domains"]
    assert "http://localhost:3000" in cors["domains"]
    assert "<regex_domain_name>" == cors["regex"]
