#!/bin/bash

echo "Starting Text Generation Web UI... (this might take a minute or two)"

# Set up SSH
if [[ $PUBLIC_KEY ]]; then
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh
	cd ~/.ssh
	echo "$PUBLIC_KEY" >>authorized_keys
	chmod 700 -R ~/.ssh
	service ssh start
fi

# Move text-generation-webui's folder to $VOLUME so models and all config will persist
/textgen-on-workspace.sh

# Initialize conda for shell script
eval "$(conda shell.bash hook)"
echo "Conda initialized"

conda activate /workspace/text-generation-webui/installer_files/env
echo "Conda environment activated"


# Create logs directory if it doesn't exist
mkdir -p /workspace/logs

# If passed a MODEL variable from Runpod template, start it downloading
# This will block the UI until completed
# MODEL can be a HF repo name, eg 'TheBloke/guanaco-7B-GPTQ'
# or it can be a direct link to a single GGML file, eg 'https://huggingface.co/TheBloke/tulu-7B-GGML/resolve/main/tulu-7b.ggmlv3.q2_K.bin'
if [[ $MODEL ]]; then
    echo "Downloading model: $MODEL"
	/fetch-model.py "$MODEL" /workspace/text-generation-webui/user_data/models 2>&1 | tee -a /workspace/logs/fetch-model.log
fi

cd /workspace/text-generation-webui
echo "Changed directory to text-generation-webui"


# Check if we have a model file to auto-load
if [[ -f /tmp/text-gen-model ]]; then
    # If this file exists, we successfully downloaded a model file or folder
    # Therefore we auto load this model
    ARGS=(--model "$(</tmp/text-gen-model)")
    UI_ARGS="${UI_ARGS} ${ARGS[@]}"
fi

(python one_click.py --listen --extensions openai ${UI_ARGS:-} 2>&1) | tee -a /workspace/logs/text-generation-webui.log
echo "Started Text Generation Web UI"

# Keep container running
while true; do
    sleep 1
done
