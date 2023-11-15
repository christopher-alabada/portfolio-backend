import pytest
import json
from app.service import content
from app.database.models import Intro, Toolbox, Experience, Project, Content
from pydantic import ValidationError


def test_read_intro():
    intro = content.read_intro()
    try:
        intro_json = json.dumps(intro)
        Intro.model_validate_json(intro_json)
    except ValidationError:
        pytest.fail("Validation error")


def test_read_toolbox():
    toolbox = content.read_toolbox()
    try:
        toolbox_json = json.dumps(toolbox)
        Toolbox.model_validate_json(toolbox_json)
    except ValidationError:
        pytest.fail("Validation error")


def test_read_experience():
    experience = content.read_experience()
    try:
        experience_element = json.dumps(experience[0])
        assert isinstance(experience, list)
        Experience.model_validate_json(experience_element)
    except ValidationError:
        pytest.fail("Validation error")


def test_read_projects():
    projects = content.read_projects()
    try:
        projects_element = json.dumps(projects[0])
        assert isinstance(projects, list)
        Project.model_validate_json(projects_element)
    except ValidationError:
        pytest.fail("Validation error")


def test_read_all_content():
    all_content = content.read_all_content()
    try:
        content_json = json.dumps(all_content)
        Content.model_validate_json(content_json)
    except ValidationError:
        pytest.fail("Validation error")
