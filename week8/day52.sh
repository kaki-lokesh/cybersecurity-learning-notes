#!/bin/bash

# DEVSECOPS CI/CD PIPELINE
  A Flask web application with an integrated GitHub Actions security pipeline.
  Every push to main automatically runs Bandit (code analysis), Safety (dependency check), and Trivy (container scan).
  The pipeline deliberately fails on a vulnerable version to demonstrate the security gate working.
