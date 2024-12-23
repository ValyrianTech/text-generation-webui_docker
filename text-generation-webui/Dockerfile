# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables
ENV LAUNCH_AFTER_INSTALL=false \
    GPU_CHOICE=N

# Install necessary system packages
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Clone the repository and run setup
RUN git clone https://github.com/WouterGlorieux/text-generation-webui.git && \
    cd text-generation-webui && \
    chmod +x start_linux.sh && \
    ./start_linux.sh

# Copy our start script
COPY start.sh ./
RUN chmod +x start.sh

# Expose the default port
EXPOSE 7860

# Use our start.sh as entrypoint
ENTRYPOINT ["./start.sh"]
