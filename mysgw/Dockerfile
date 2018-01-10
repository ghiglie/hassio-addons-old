ARG BUILD_FROM
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

FROM ${BUILD_FROM}

ENV CONFIG_PATH=/data/options.json
ENV APPDIR=/opt/MySensors

RUN apt-get update && apt-get install -y --force-yes \
     make \
	 g++ \
	 git \
	 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache \
	 && git clone https://github.com/mysensors/MySensors.git --branch development $APPDIR


# Copy root filesystem
COPY rootfs /

# Labels
LABEL \
    io.hass.name="MySensors Gateway" \
    io.hass.description="MySensors Gateway" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Marco Ghiglieri <ghiglie@yahoo.it>" \
    org.label-schema.description="MySensors Gateway" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="MySensors Gateway" \
    org.label-schema.schema-version="0.1" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/ghiglie/hassio-addons/addon-mysgw/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/ghiglie/hassio-addons/addon-mysgw" \
    org.label-schema.vendor="Marco Ghiglieri Hass.io Add-ons"

CMD [ "/run.sh" ]