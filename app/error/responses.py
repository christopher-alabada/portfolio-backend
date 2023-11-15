from fastapi.responses import JSONResponse


def not_found():
    not_found_message = {"error": {"code": 404, "message": "Not found"}}
    return JSONResponse(status_code=404, content=not_found_message)


def internal_server_error():
    internal_error_message = {
        "error": {"code": 500, "message": "There was an unknown error"}
    }
    return JSONResponse(status_code=500, content=internal_error_message)
