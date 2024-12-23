# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH
ENV PYTHONNOUSERSITE=1
ENV LAUNCH_AFTER_INSTALL=false

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

# Initialize conda in .bashrc
RUN echo '. /opt/conda/etc/profile.d/conda.sh' >> ~/.bashrc && \
    echo 'conda activate base' >> ~/.bashrc

# Set working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/WouterGlorieux/text-generation-webui.git .

# Make start script executable and run it
RUN chmod +x start_linux.sh && \
    ./start_linux.sh

# Copy our start script
COPY start.sh ./
RUN chmod +x start.sh

# Expose the default port
EXPOSE 7860

# Use our start.sh as entrypoint
ENTRYPOINT ["./start.sh"]
