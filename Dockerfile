# in your Dockerfile
FROM sphinxdoc/sphinx:4.1.2

ARG PIP_INSTALL="pip install --no-cache-dir --upgrade"

COPY ./requirements.txt requirements.txt

RUN ${PIP_INSTALL} pip && \
    ${PIP_INSTALL} -r requirements.txt

# -v $(pwd):/docs
WORKDIR /docs

EXPOSE 8000 35729

CMD ["make", "livehtml"]
