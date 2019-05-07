ARG BUILD_FROM
FROM $BUILD_FROM as builder
ENV LANG C.UTF-8
RUN apk add --no-cache make gcc musl-dev m4 intltool libtool dbus-dev libcap-dev alsa-lib-dev bluez-dev speexdsp-dev avahi-dev libressl-dev eudev-dev libsndfile-dev json-c-dev fftw-dev sbc-dev jack-dev
ADD https://freedesktop.org/software/pulseaudio/releases/pulseaudio-12.2.tar.gz /
RUN tar xfz pulseaudio-12.2.tar.gz
WORKDIR /pulseaudio-12.2
RUN ./configure
RUN make
RUN make install

FROM $BUILD_FROM
ENV LANG C.UTF-8
RUN apk add --no-cache dbus libcap alsa-lib bluez speexdsp avahi libressl eudev libsndfile json-c fftw sbc jack libltdl gdbm
COPY --from=builder /usr/local/ /usr/local
COPY default.pa client.conf daemon.conf /usr/local/etc/pulse/
RUN mkdir -p /usr/local/var/lib
CMD /usr/local/bin/pulseaudio --disallow-exit --disable-shm
