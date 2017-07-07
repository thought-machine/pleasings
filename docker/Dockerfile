FROM thoughtmachine/please_ubuntu:latest
MAINTAINER peter.ebden@gmail.com

# OpenFST / Thrax
WORKDIR /tmp
RUN curl -sSf http://www.openfst.org/twiki/pub/FST/FstDownload/openfst-1.6.3.tar.gz | tar -xz && \
    cd openfst-1.6.3 && \
    ./configure --enable-static --enable-shared --enable-lookahead-fsts --enable-grm --enable-compact-fsts --enable-const-fsts && \
    make -j4 && \
    make install && \
    rm -rf /tmp/openfst-1.6.3
RUN curl -sSf http://openfst.cs.nyu.edu/twiki/pub/GRM/ThraxDownload/thrax-1.2.3.tar.gz | tar -xz && \
    cd thrax-1.2.3 && \
    ./configure --enable-static --enable-shared && \
    make -j4 && \
    make install && \
    rm -rf /tmp/thrax-1.2.3

# Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/.cargo/bin
