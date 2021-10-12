ARG BUILD_ENV

FROM python:slim as localimage
ONBUILD COPY source /etc

FROM python:slim as image

FROM ${BUILD_ENV}image

LABEL maintainer="Pan Chen"

# alias for the software installation
ARG PIP_INSTALL="pip install --no-cache-dir --upgrade"

# .build-deps for building Pillow
COPY ./requirements.txt requirements.txt

RUN ${PIP_INSTALL} pip && \
    ${PIP_INSTALL} -r requirements.txt

# -v $(pwd):/docs
WORKDIR /docs

EXPOSE 8000 35729

CMD ["make", "livehtml"]
