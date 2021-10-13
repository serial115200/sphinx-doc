ARG BUILD_ENV

FROM python:slim as localimage
ONBUILD COPY source /etc

FROM python:slim as image

FROM ${BUILD_ENV}image

LABEL maintainer="Pan Chen"

# alias for the software installation
ARG PIP_INSTALL="pip install --no-cache-dir --upgrade"
ARG APT_INSTALL="apt-get install --no-install-recommends -y"

RUN     apt-get update \
    &&  ${APT_INSTALL} graphviz imagemagick make \
    &&  apt-get autoremove \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*
# .build-deps for building Pillow
COPY ./requirements.txt requirements.txt

RUN ${PIP_INSTALL} pip && \
    ${PIP_INSTALL} -r requirements.txt

# -v $(pwd):/docs
WORKDIR /docs

EXPOSE 8000 35729

CMD ["make", "livehtml"]
