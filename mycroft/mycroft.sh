#!/bin/bash

mkdir -p $HOME
virtualenv --python /usr/bin/python3 --system-site-packages $HOME/venv
source $HOME/venv/bin/activate

server=$(jq --raw-output .pulse_server /data/options.json)
if [ ! -z "$server" ]; then
  echo Setting PULSE_SERVER environment variable to $server and removing aplay configuration.
  export PULSE_SERVER=$server
  sed -i /aplay/d /etc/mycroft/mycroft.conf
  unset ALSA_INPUT
  unset ALSA_OUTPUT
  if [ ! -e "$HOME/.asoundrc" ]; then
    echo Populating $HOME/.asoundrc to load PulseAudio plugin.
    cp /etc/mycroft/asoundrc $HOME/.asoundrc
  fi
fi

chown -R mycroft $HOME

exec supervisord -c /etc/supervisord.conf
