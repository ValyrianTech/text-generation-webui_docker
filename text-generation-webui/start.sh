#!/bin/bash

# Source conda
. /opt/conda/etc/profile.d/conda.sh

# Activate the environment
conda activate /app/installer_files/env

# Set environment variable to skip GPU choice
export GPU_CHOICE="N"

# Run the application
python one_click.py

# Keep container running
while true; do
    sleep 1
done
