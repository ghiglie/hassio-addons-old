ARG BUILD_FROM
FROM $BUILD_FROM
ENV VERSION 18.8.13
RUN apt-get update && apt-get install -y jq git python3-dev python3-setuptools swig build-essential libfann-dev libz-dev libjpeg-dev libopenjp2-7-dev libtiff-dev libtiff5-dev linux-libc-dev libasound2-dev portaudio19-dev alsa-utils supervisor virtualenv libpulse-dev mpg123 flac pulseaudio-utils vorbis-tools python3-pip espeak libasound2-plugins
RUN pip3 install --upgrade pip pyasn1
RUN git clone https://github.com/mycroftai/mycroft-core
WORKDIR /mycroft-core
RUN env
RUN git checkout release/v$VERSION
RUN pip3 install -r requirements.txt
RUN python3 setup.py install
RUN sed -i "s:/usr/bin/python3:/usr/bin/env python3:" /usr/local/bin/mycroft-*
WORKDIR /
RUN rm -rf /mycroft
RUN adduser --system --no-create-home mycroft
RUN adduser mycroft audio
ENV HOME /config/mycroft
ENV PYTHON_EGG_CACHE $HOME/.cache/.Python-Eggs
COPY mycroft.conf /etc/mycroft/mycroft.conf
COPY asoundrc /etc/mycroft/asoundrc
COPY supervisord.conf /etc/
COPY mycroft.sh /usr/local/bin/
CMD /usr/local/bin/mycroft.sh
