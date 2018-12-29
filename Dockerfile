FROM ubuntu:18.04
RUN export DEBIAN_FRONTEND=noninteractive

# Get it to install basic stuff
RUN apt-get update
RUN apt-get install --no-install-recommends -y software-properties-common \
    pkg-config \
    build-essential \
    libatomic1 \
    git \
    python \
    perl \
    gfortran \
    make \
    zlib1g-dev \
    apt-transport-https \
    wget \
    m4

ENV HOME /root
ENV USER docker
ENV JULIA_SRC /julia

RUN wget -qO- "https://cmake.org/files/v3.12/cmake-3.12.1-Linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr

# Install Julia in debug mode
RUN git clone https://github.com/JuliaLang/julia.git /julia
WORKDIR $JULIA_SRC
RUN git checkout v1.0.3
RUN make debug

