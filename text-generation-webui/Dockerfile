# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables
ENV LAUNCH_AFTER_INSTALL=false \
    GPU_CHOICE=A \
    USE_CUDA118=false \
    PATH="/root/miniconda3/bin:${PATH}" \
    CONDA_AUTO_UPDATE_CONDA=false

# Install necessary system packages
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p /root/miniconda3 && \
    rm ~/miniconda.sh && \
    conda init bash

# Set working directory
WORKDIR /root

COPY --chmod=755 testgen-on-workspace.sh /textgen-on-workspace.sh

# Clone the repository and run setup
RUN git clone https://github.com/oobabooga/text-generation-webui.git && \
    cd text-generation-webui && \
    chmod +x start_linux.sh && \
    ./start_linux.sh

# Copy our start script
COPY start.sh ./
RUN chmod +x start.sh

# Expose the default port
EXPOSE 7860
ENV LAUNCH_AFTER_INSTALL=true

# Use our start.sh as entrypoint
ENTRYPOINT ["./start.sh"]
