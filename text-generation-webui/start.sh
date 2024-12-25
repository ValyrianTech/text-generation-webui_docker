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

cd /workspace/text-generation-webui
echo "Changed directory to text-generation-webui"

python one_click.py --listen --extensions openai ${UI_ARGS:-}
echo "Started Text Generation Web UI"

# Keep container running
while true; do
    sleep 1
done
