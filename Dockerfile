ARG BUILD_ENV

FROM python:3.9.5-alpine3.13 as localimage
ONBUILD COPY source /etc

FROM python:3.9.5-alpine3.13 as image

FROM ${BUILD_ENV}image

LABEL maintainer="Pan Chen"

# alias for the software installation
ARG APK_INSTALL="apk add --no-cache"
ARG PIP_INSTALL="pip install --no-cache-dir --upgrade"
ARG APK_UNINSTALL="apk del"

RUN ${APK_INSTALL} graphviz imagemagick make

# .build-deps for building Pillow
COPY ./requirements.txt requirements.txt
RUN ${APK_INSTALL} --virtual .build-deps build-base jpeg-dev zlib-dev && \
    ${PIP_INSTALL} pip && \
    ${PIP_INSTALL} -r requirements.txt && \
    ${APK_UNINSTALL} .build-deps

# -v $(pwd):/docs
WORKDIR /docs

EXPOSE 8000 35729

CMD ["make", "livehtml"]
