FROM ubuntu:18.04
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gcc \
        git \
        libcurl4-openssl-dev \
        libsqlite3-dev \
        make \
        xz-utils
RUN curl -fsS https://dlang.org/install.sh | bash -s dmd
RUN git clone https://github.com/skilion/onedrive \
    && cd onedrive \
    && . ~/dlang/dmd-*/activate \
    && make \
    && make install

FROM ubuntu:18.04
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        libcurl4-openssl-dev \
        libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*
COPY --from=0 /usr/local/bin/onedrive /usr/local/bin/onedrive
