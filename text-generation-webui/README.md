# Docker Text Generation WebUI

A Docker-based setup for running [oobabooga/text-generation-webui](https://github.com/oobabooga/text-generation-webui) with enhanced features for model management and persistence.

## Features

- 🐳 Containerized text-generation-webui environment
- 📦 Persistent storage for models and configurations
- 🔄 Automatic model downloads via environment variables
- 🔒 Optional SSH access support
- 🚀 OpenAI API compatibility


## Quick Start

1. Build the Docker image:
```bash
docker build -t text-gen-webui .
```

2. Run the container:
```bash
docker run -d \
  -p 7860:7860 \
  -v /path/to/workspace:/workspace \
  --name text-gen-webui \
  text-gen-webui
```

## Environment Variables

- `MODEL`: HuggingFace model path or direct URL to model file
  ```bash
  # Example with HuggingFace model:
  -e MODEL="TheBloke/guanaco-7B-GPTQ"
  
  # Example with direct URL:
  -e MODEL="https://huggingface.co/TheBloke/tulu-7B-GGML/resolve/main/tulu-7b.ggmlv3.q2_K.bin"
  ```

- `PUBLIC_KEY`: SSH public key for remote access
  ```bash
  -e PUBLIC_KEY="your-ssh-public-key"
  ```

- `UI_ARGS`: Additional arguments for text-generation-webui
  ```bash
  -e UI_ARGS="--multimodal-pipeline llava-v1.5-13b"
  ```

## Directory Structure

- `/workspace/text-generation-webui`: Persistent storage location
- `/root/text-generation-webui`: Symbolic link to workspace
- Models are stored in `/workspace/text-generation-webui/user_data/models`

## Model Management

### Automatic Model Download

The container can automatically download models on startup using the `MODEL` environment variable:

```bash
docker run -d \
  -p 7860:7860 \
  -v /path/to/workspace:/workspace \
  -e MODEL="TheBloke/guanaco-7B-GPTQ" \
  text-gen-webui
```

### Manual Model Download

You can also use the included Python scripts to manage models:

- `fetch-model.py`: Quick model download with retry support
- `download_model.py`: Advanced model management with checksum validation

## SSH Access

To enable SSH access:

1. Set your public key via the `PUBLIC_KEY` environment variable
2. Map the SSH port:
```bash
docker run -d \
  -p 7860:7860 \
  -p 22:22 \
  -e PUBLIC_KEY="your-ssh-public-key" \
  text-gen-webui
```
