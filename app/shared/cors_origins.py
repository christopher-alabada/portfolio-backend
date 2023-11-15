from pydantic import BaseModel


class CorsOrigin(BaseModel):
    domains: list[str]
    regex: str


def get_cors_origins() -> CorsOrigin:
    return {
        "domains": [
            "http://127.0.0.1:3000",
            "http://localhost:3000",
        ],
        "regex": "<regex_domain_name>",
    }
