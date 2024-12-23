#!/bin/bash

echo "Starting Text Generation Web UI... (this might take a minute or two)"
conda activate /workspace/text-generation-webui/installer_files/env
cd /workspace/text-generation-webui
python one_click.py --listen --extensions openai

# Keep container running
while true; do
    sleep 1
done
