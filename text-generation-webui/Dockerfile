FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04 as cuda
FROM continuumio/miniconda3:latest

# Copy CUDA runtime from NVIDIA image
COPY --from=cuda /usr/local/cuda-12.1 /usr/local/cuda-12.1

# Set CUDA environment variables
ENV PATH=/usr/local/cuda-12.1/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda-12.1/lib64:${LD_LIBRARY_PATH}
ENV CUDA_HOME=/usr/local/cuda-12.1

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    cmake \
    pkg-config \
    libcairo2-dev \
    libglib2.0-0 \
    python3-dev \
    gcc \
    g++ \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory and create installer directory structure
WORKDIR /app
RUN mkdir -p installer_files/conda installer_files/env

# Environment isolation variables (matching bash script)
ENV PYTHONNOUSERSITE=1
ENV PYTHONPATH=""
ENV PYTHONHOME=""
ENV CUDA_PATH="/app/installer_files/env"
ENV CUDA_HOME="/app/installer_files/env"

# Clone text-generation-webui
RUN git clone https://github.com/WouterGlorieux/text-generation-webui.git .

# Create conda environment with Python 3.10 (matching bash script version)
RUN conda create -y -k --prefix /app/installer_files/env python=3.10

# Initialize conda in bash
SHELL ["/bin/bash", "-c"]

# Set conda environment path
ENV PATH="/app/installer_files/env/bin:$PATH"

# Install PyTorch with CUDA support
RUN conda run --prefix /app/installer_files/env pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Install basic dependencies
RUN conda run --prefix /app/installer_files/env pip3 install wheel setuptools ninja

# Copy and install requirements
COPY requirements.txt /app/requirements.txt
RUN conda run --prefix /app/installer_files/env pip3 install -r requirements.txt --no-deps && \
    conda run --prefix /app/installer_files/env pip3 install -r requirements.txt

# Copy one_click.py (if it exists in your setup)
COPY one_click.py /app/one_click.py

# Expose the default port
EXPOSE 7860

# Command to run the web UI (can be modified to use one_click.py if needed)
CMD ["conda", "run", "--prefix", "/app/installer_files/env", "python", "server.py", "--listen"]