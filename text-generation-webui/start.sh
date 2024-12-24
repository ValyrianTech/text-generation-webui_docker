#!/bin/bash

echo "Starting Text Generation Web UI... (this might take a minute or two)"

# Initialize conda for shell script
eval "$(conda shell.bash hook)"
echo "Conda initialized"

conda activate /workspace/text-generation-webui/installer_files/env
echo "Conda environment activated"

cd /workspace/text-generation-webui
echo "Changed directory to text-generation-webui"

python one_click.py --listen --extensions openai ${UI_ARGS:-}
echo "Started Text Generation Web UI"

# Keep container running
while true; do
    sleep 1
done
