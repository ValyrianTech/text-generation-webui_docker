FROM continuumio/miniconda3:latest

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install CUDA toolkit
RUN conda install -y -c conda-forge cudatoolkit=12.1

# Set working directory
WORKDIR /app

# Clone text-generation-webui from your fork
RUN git clone https://github.com/WouterGlorieux/text-generation-webui.git .

# Create conda environment
RUN conda create -y -n textgen python=3.11

# Initialize conda in bash
SHELL ["/bin/bash", "-c"]

# Set environment variables
ENV CONDA_DEFAULT_ENV=textgen
ENV PYTHONNOUSERSITE=1
ENV CUDA_PATH="/opt/conda/envs/textgen"
ENV CUDA_HOME="$CUDA_PATH"
ENV PATH="/opt/conda/envs/textgen/bin:$PATH"
ENV LD_LIBRARY_PATH="$CUDA_HOME/lib64:$LD_LIBRARY_PATH"

# Activate environment and install dependencies
RUN conda run -n textgen pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 && \
    conda run -n textgen pip3 install -r requirements.txt

# Expose the default port
EXPOSE 7860

# Command to run the web UI
CMD ["conda", "run", "-n", "textgen", "python", "server.py", "--listen"]