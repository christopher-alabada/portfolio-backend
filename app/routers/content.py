from fastapi import APIRouter
from app.database.models import Intro, Toolbox, Experience, Project, Content
from app.service import content

router = APIRouter(prefix="/content", tags=["content"])


@router.get("")
async def read_all_content() -> Content:
    return content.read_all_content()


@router.get("/intro")
async def read_intro() -> Intro:
    return content.read_intro()


@router.get("/toolbox")
async def read_toolbox() -> Toolbox:
    return content.read_toolbox()


@router.get("/experiences")
async def read_experience() -> list[Experience]:
    return content.read_experience()


@router.get("/projects")
async def read_projects() -> list[Project]:
    return content.read_projects()
