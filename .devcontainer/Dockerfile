# FROM nginx:1.28-alpine

# RUN apk add --no-cache \
#     bash \
#     git \
#     curl

# WORKDIR /workspace


# Ubuntu 24.04 Dev Container
# FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system packages
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
    unzip \
    git \
    vim \
    nano \
    jq \
    zip \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    bash-completion \
    && rm -rf /var/lib/apt/lists/*

# -------------------------
# Install AWS CLI v2
# -------------------------
# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
#     unzip awscliv2.zip && \
#     ./aws/install

RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "arm64" ]; then \
        curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"; \
    else \
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    fi && \
    unzip awscliv2.zip && \
    ./aws/install

# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
#     -o "/tmp/awscliv2.zip" \
#     && unzip /tmp/awscliv2.zip -d /tmp \
#     && /tmp/aws/install \
#     && rm -rf /tmp/aws /tmp/awscliv2.zip

# -------------------------
# Install Terraform
# -------------------------
RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt update && apt install terraform
# RUN wget -O- https://apt.releases.hashicorp.com/gpg \
#     | gpg --dearmor \
#     | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null && \
#     echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
#     https://apt.releases.hashicorp.com \
#     $(lsb_release -cs) main" \
#     | tee /etc/apt/sources.list.d/hashicorp.list && \
#     apt-get update && \
#     apt-get install -y terraform && \
#     rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

COPY . .

CMD ["/bin/bash"]