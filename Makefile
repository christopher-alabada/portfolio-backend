VENV := venv
PYTHON := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

all: venv

venv: $(VENV)/bin/activate

run: venv
	$(PYTHON) -m uvicorn app.main:app --reload

clean:
	rm -rf $(VENV)
	find . -type d -name "__pycache__" | xargs rm -rfv

tests: venv
	$(PYTHON) -m pytest
	$(PYTHON) -m pytest --cov=app tests/
	find . -type d -name "__pycache__" | xargs rm -rf

build:
	python -m venv $(VENV)
	$(PIP) install --no-cache-dir --platform manylinux2014_x86_64 --target=package --implementation cp --python-version 3.11 --only-binary=:all: --requirement requirements.txt
	find . -type d -name "__pycache__" | xargs rm -rfv
	cd package; zip -rX ../function.zip .; cd ..; zip -rXg ./function.zip app
	rm -rf package

$(VENV)/bin/activate: requirements.txt
	python -m venv $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt

.PHONY: all venv run clean tests build
