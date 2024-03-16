FROM python:3.12-slim-bullseye

ARG MODELS

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    software-properties-common sudo curl\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' localllm
RUN adduser localllm sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER root
COPY scripts/pull-models.sh /home/localllm/scripts/pull-models.sh

RUN chmod +x /home/localllm/scripts/pull-models.sh 
RUN pip install litellm[proxy]
RUN curl https://ollama.ai/install.sh | sh

USER localllm
WORKDIR /home/localllm    

RUN /home/localllm/scripts/pull-models.sh $MODELS

