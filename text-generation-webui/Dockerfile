# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/WouterGlorieux/text-generation-webui.git .

# Make the start script executable
RUN chmod +x start_linux.sh

# Set the entry point
CMD ["./start_linux.sh"]
