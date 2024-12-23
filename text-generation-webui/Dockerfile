# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH
ENV PYTHONNOUSERSITE=1

# Install necessary system packages
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py310_23.3.1-0-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p $CONDA_DIR && \
    rm ~/miniconda.sh

# Set working directory
WORKDIR /app

# Clone the repository first to get all files
RUN git clone https://github.com/ValyrianTech/text-generation-webui_with_pixtral.git .

# Copy our modified setup script
COPY docker_setup.sh ./
RUN chmod +x docker_setup.sh

# Run the setup script (this handles conda env creation and dependencies)
RUN /bin/bash -c "./docker_setup.sh"

# Expose the default port
EXPOSE 7860

# Set the entrypoint to run one_click.py
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["source /opt/conda/etc/profile.d/conda.sh && conda activate /app/installer_files/env && cd /app/text-generation-webui && python one_click.py"]
