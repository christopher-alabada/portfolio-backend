from app.shared.cors_origins import get_cors_origins
from fastapi import FastAPI, Request
from fastapi.exceptions import HTTPException
from fastapi.middleware.cors import CORSMiddleware
from app.routers import content
from app.error import responses
from mangum import Mangum


app = FastAPI()

cors_origins = get_cors_origins()

app.add_middleware(
    CORSMiddleware,
    allow_origins=cors_origins["domains"],
    allow_origin_regex=cors_origins["regex"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(content.router)


@app.exception_handler(404)
async def not_found_handler(request: Request, exc: HTTPException):
    return responses.not_found()


@app.exception_handler(500)
async def internal_error_handler(requests: Request, exc: HTTPException):
    return responses.internal_server_error()


handler = Mangum(app)
