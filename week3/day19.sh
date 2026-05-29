#!/bin/bash

# ARGPARSE
  'argparse' is Python's standard library module for building CLIs.
  It handles argument parsing, generates help text automatically, validates input types and provides error messages.

  # This concept is practiced in python file: argparse_masterclass.py

# VIRTUAL ENVIRONMENTS
  A virtual environment creates an isolated Python installation for each project.
  This prevents dependency conflicts - if projectA -> requests==2.28 & projectB -> requests==2.31, they can coexist in seperate environments.
# Virtual Environment Commands
1. python3 -m venv venv : Creates a virtual environment
   Contains: its own Python interpreter + pip + site-packages
2. source venv/bin/activate : Activate the environment (Linux/WSL2)
   venv\Scripts\activate : On Windows PowerShell
   (venv) prefix shows environment is active
3. pip install <lib names for project> : Install project dependencies
4. pip freeze > requirements.txt : Generate requirements.txt (records exact versions installed)
   This file goes into github repo.
   To recreate the exact environment- pip install -r requirements.txt
5. deactivate : Deactivate the environment
6. .gitignore : NEVER commit the venv/ folder to github

# MODULAR CODE
  When tools grow, they are split into modules - seperate .py files that each handle one concern.
  This makes code reusable, testable and easier to maintain.

