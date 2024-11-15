FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.10 python3.10-venv python3.10-dev python3-pip git ninja-build tzdata wget && \
    rm -rf /var/lib/apt/lists/*

RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN python3 -m pip install --upgrade pip && \
    pip install html5lib

WORKDIR /app
COPY . /app

# Install a compatible version of PyTorch
# RUN pip install torch==<version>+cu118 torchvision==<version>+cu118 torchaudio==<version>+cu118 -f https://download.pytorch.org/whl/torch_stable.html

ENV CUDA_HOME=/usr/local/cuda

# RUN git clone https://github.com/graphdeco-inria/diff-gaussian-rasterization.git && \
#     cd diff-gaussian-rasterization && \
#     pip install .

CMD ["python", "app.py"]