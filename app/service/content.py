import json
from app.database.models import Intro, Toolbox, Experience, Project, Content


def read_intro() -> Intro:
    with open("app/data/intro.json") as stream:
        intro = json.load(stream)
    return intro


def read_toolbox() -> Toolbox:
    with open("app/data/toolbox.json") as stream:
        toolbox = json.load(stream)
    return toolbox


def read_experience() -> list[Experience]:
    with open("app/data/experience.json") as stream:
        experience = json.load(stream)
    return experience


def read_projects() -> list[Project]:
    with open("app/data/projects.json") as stream:
        projects = json.load(stream)
    return projects


def read_all_content() -> Content:
    intro = read_intro()
    toolbox = read_toolbox()
    experience = read_experience()
    projects = read_projects()
    return {
        "intro": intro,
        "toolbox": toolbox,
        "experience": experience,
        "projects": projects,
    }
