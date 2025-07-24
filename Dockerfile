# Use the jammy Ubuntu image
FROM ubuntu:jammy

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    gnupg \
    software-properties-common \
    git \
    build-essential \ 
    autoconf \
    automake \
    clang-15 \
    libclang-15-dev \
    llvm-15 \
    llvm-15-dev \
    clang-12 \
    libclang-12-dev \
    llvm-12 \
    llvm-12-dev \
    libffi-dev \
	zlib1g-dev \ 
    libedit-dev \
    python3.10 \
    python3-pip

WORKDIR /root

RUN git clone https://github.com/matteo-meluzzi/genmc-xmm-master-thesis genmc-dev
RUN git clone https://github.com/matteo-meluzzi/genmc-xmm-master-thesis genmc-xmm
RUN git clone https://github.com/matteo-meluzzi/genmc-xmm-master-thesis genmc-wkmo
RUN git clone https://github.com/matteo-meluzzi/xmm-benchmarks xmm-benchmarks

WORKDIR /root/genmc-dev
RUN git checkout genmc-dev
RUN autoreconf --install
RUN ./configure --with-llvm=/usr/lib/llvm-15
RUN make

WORKDIR /root/genmc-xmm
RUN git checkout genmc-xmm
RUN autoreconf --install
RUN ./configure --with-llvm=/usr/lib/llvm-15
RUN make

WORKDIR /root/genmc-wkmo
RUN git checkout genmc-wkmo
RUN autoreconf --install
RUN ./configure --with-llvm=/usr/lib/llvm-12
RUN make

WORKDIR /root/xmm-benchmarks    
RUN pip install notebook
RUN pip install -r requirements.txt