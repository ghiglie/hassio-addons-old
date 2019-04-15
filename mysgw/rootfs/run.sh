#!/usr/bin/with-contenv bash
source /usr/lib/hassio-addons/base.sh

echo "MySensors Gateway"
MYSGW_TYPE=$(hass.jq "${CONFIG_PATH}" ".type")
MYSGW_TRN=$(hass.jq "${CONFIG_PATH}" ".transport")
MQTT_SERVER=$(hass.jq "${CONFIG_PATH}" ".mqtt_server")
MQTT_CLIENTID=$(hass.jq "${CONFIG_PATH}" ".mqtt_clientid")
MQTT_TOPIC_IN=$(hass.jq "${CONFIG_PATH}" ".mqtt_topicin")
MQTT_TOPIC_OUT=$(hass.jq "${CONFIG_PATH}" ".mqtt_topicout")

MQTT_OPTS="--my-mqtt-client-id=$MQTT_CLIENTID --my-controller-url-address=$MQTT_SERVER --my-mqtt-publish-topic-prefix=$MQTT_TOPIC_OUT --my-mqtt-subscribe-topic-prefix=$MQTT_TOPIC_IN"

cd $APPDIR
./configure --spi-spidev-device=/dev/spidev0.0 --my-transport=$MYSGW_TRN --my-gateway=$MYSGW_TYPE $MQTT_OPTS
make && make install
./bin/mysgw --daemon
