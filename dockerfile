FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.10 python3.10-venv python3.10-dev python3-pip git ninja-build tzdata wget && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get install -y libglm-dev libgl1

RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN python3 -m pip install --upgrade pip && \
    pip install html5lib

WORKDIR /app
COPY . /app

RUN pip install torch==2.5.0+cu118 torchvision==0.20.0+cu118 torchaudio==2.5.0+cu118 --index-url https://download.pytorch.org/whl/cu118
RUN pip install /app/diff-gaussian-rasterization/
RUN pip install -U xformers --index-url https://download.pytorch.org/whl/cu118


ENV CUDA_HOME=/usr/local/cuda

RUN git clone https://github.com/graphdeco-inria/diff-gaussian-rasterization.git
RUN pip install /app/diff-gaussian-rasterization