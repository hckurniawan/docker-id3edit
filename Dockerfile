# BUILD: hckurniawan/id3edit:2.1.3

###
# Compile
###
ARG BUILD_DOCKER_BUILDER_BASE_IMAGE="debian:12.1"
FROM "${BUILD_DOCKER_BUILDER_BASE_IMAGE}" as complier

ARG DOCKER_BUILD_RESOURCE_LIBPRINTHEX_VERSION="1.0.1"
ARG DOCKER_BUILD_RESOURCE_ID3EDIT_VERSION="2.1.3"
ARG DOCKER_BUILD_RESOURCE_LIBPRINTHEX_GITHUB="https://github.com/rstemmer/libprinthex"
ARG DOCKER_BUILD_RESOURCE_ID3EDIT_FILE="https://github.com/rstemmer/id3edit"

RUN apt update \
    && apt install -y wget clang zlib1g zlib1g-dev unzip

WORKDIR /build
RUN wget -O libprinthex.zip "${DOCKER_BUILD_RESOURCE_LIBPRINTHEX_GITHUB}/archive/refs/tags/v${DOCKER_BUILD_RESOURCE_LIBPRINTHEX_VERSION}.zip" \
    && unzip libprinthex.zip \
    && cd "libprinthex-${DOCKER_BUILD_RESOURCE_LIBPRINTHEX_VERSION}" \
    && ./build.sh \
    && ./install.sh

WORKDIR /build
RUN wget -O id3edit.zip "${DOCKER_BUILD_RESOURCE_ID3EDIT_FILE}/archive/refs/tags/v${DOCKER_BUILD_RESOURCE_ID3EDIT_VERSION}.zip" \
    && unzip id3edit.zip \
    && cd "id3edit-${DOCKER_BUILD_RESOURCE_ID3EDIT_VERSION}" \
    && ./build.sh \
    && ./install.sh


###
# Build image
###
FROM "${BUILD_DOCKER_BUILDER_BASE_IMAGE}"
RUN apt update \
    && apt install -y zlib1g \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=complier /usr/local/lib/libprinthex.a /usr/local/lib/libprinthex.a
COPY --from=complier /usr/local/bin/id3edit /usr/local/bin/id3edit
COPY --from=complier /usr/local/bin/id3show /usr/local/bin/id3show
COPY --from=complier /usr/local/bin/id3frames /usr/local/bin/id3frames
COPY --from=complier /usr/local/bin/id3dump /usr/local/bin/id3dump
