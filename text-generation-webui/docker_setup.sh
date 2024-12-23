#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# deactivate existing conda envs as needed to avoid conflicts
{ conda deactivate && conda deactivate && conda deactivate; } 2> /dev/null

OS_ARCH=$(uname -m)
case "${OS_ARCH}" in
    x86_64*)    OS_ARCH="x86_64";;
    arm64*)     OS_ARCH="aarch64";;
    aarch64*)   OS_ARCH="aarch64";;
    *)          echo "Unknown system architecture: $OS_ARCH! This script runs only on x86_64 or arm64" && exit
esac

# config
INSTALL_DIR="$(pwd)/installer_files"
CONDA_ROOT_PREFIX="/opt/conda"  # Changed to match Dockerfile
INSTALL_ENV_DIR="$(pwd)/installer_files/env"

# create the installer env
if [ ! -e "$INSTALL_ENV_DIR" ]; then
    "$CONDA_ROOT_PREFIX/bin/conda" create -y -k --prefix "$INSTALL_ENV_DIR" python=3.11
fi

# check if conda environment was actually created
if [ ! -e "$INSTALL_ENV_DIR/bin/python" ]; then
    echo "Conda environment is empty."
    exit
fi

# environment isolation
export PYTHONNOUSERSITE=1
unset PYTHONPATH
unset PYTHONHOME
export CUDA_PATH="$INSTALL_ENV_DIR"
export CUDA_HOME="$CUDA_PATH"

# activate installer env
source "$CONDA_ROOT_PREFIX/etc/profile.d/conda.sh"
conda activate "$INSTALL_ENV_DIR"

# setup installer env without running the server
python one_click.py --skip-launch
