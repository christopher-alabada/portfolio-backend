from pydantic import BaseModel
from typing import Optional


class IconLabel(BaseModel):
    image: str
    name: str


class Intro(BaseModel):
    title: str
    body: list[str]


class Toolbox(BaseModel):
    languages: list[IconLabel]
    frameworks: list[IconLabel]
    databases: list[IconLabel]
    miscellaneous: list[IconLabel]


class Experience(BaseModel):
    position: str
    company: str
    location: str
    date: str
    description: list[str]


class Project(BaseModel):
    name: str
    description: str
    repo: Optional[str] = None
    skills: list[str]


class Content(BaseModel):
    intro: Intro
    toolbox: Toolbox
    experience: list[Experience]
    projects: list[Project]
