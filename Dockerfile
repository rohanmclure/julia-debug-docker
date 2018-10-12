FROM ubuntu:18.04

# Get it to install basic stuff
RUN apt-get update
RUN apt-get install --no-install-recommends -y software-properties-common \
    pkg-config \
    build-essential \
    libatomic1 \
    git \
    python \
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
RUN make debug

# Install R
RUN apt-get install --no-install-recommends -y dirmngr gpg-agent
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
RUN apt-get update
RUN apt-get install --no-install-recommends -y r-base
RUN apt-get install --no-install-recommends -y libcurl4-openssl-dev libssl-dev

