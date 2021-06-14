ARG DEBIAN_VERSION_NAME
ARG NODE_VERSION

FROM node:${NODE_VERSION}-${DEBIAN_VERSION_NAME}-slim

WORKDIR /app

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

RUN \
  apt-get update \
  && apt-get install -fqq --no-install-recommends \
  python3 \
  python3-pip \
  && pip3 install fonttools brotli zopfli \
  && npm i -g glyphhanger \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

ENTRYPOINT [ "glyphhanger" ]

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL

LABEL \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vendor="Territory Embrace | Talentplatforms" \
  org.label-schema.vcs-url="${VCS_URL}" \
  org.label-schema.vcs-ref="${VCS_REF}" \
  org.label-schema.name="glyphhanger" \
  org.label-schema.version="${NODE_VERSION}-${DEBIAN_VERSION_NAME}-slim" \
  org.label-schema.build-date="${BUILD_DATE}" \
  org.label-schema.description="a tool to optimize webfonts"
