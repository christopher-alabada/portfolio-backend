from fastapi.responses import JSONResponse


def not_found():
    not_found_message = {"error": {"code": 404, "message": "Not found"}}
    return JSONResponse(status_code=404, content=not_found_message)
