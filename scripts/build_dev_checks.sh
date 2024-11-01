#!/bin/bash
set -e

rm -rf dev_venv
python3 -m venv .venv_dev
source .venv_dev/bin/activate

pip install --upgrade pip
pip install -e ".[dev]"

pip freeze > dev-requirements.txt

# Type Check
python -m mypy

# Doctype Check
darglint src/redis_dict/

# Multiple linters
python -m pylama -i E501,E231 src

# Unit tests
python -m unittest discover -s tests

# Docstring Check
# pydocstyle src/redis_dict/

deactivate
