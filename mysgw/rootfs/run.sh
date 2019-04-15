#!/usr/bin/with-contenv bash
source /usr/lib/hassio-addons/base.sh

echo "MySensors Gateway"
MYSGW_TYPE=$(hass.jq "${CONFIG_PATH}" ".type")
MYSGW_TRN=$(hass.jq "${CONFIG_PATH}" ".transport")
MQTT_SERVER=$(hass.jq "${CONFIG_PATH}" ".mqtt_server")
MQTT_CLIENTID=$(hass.jq "${CONFIG_PATH}" ".mqtt_clientid")
MQTT_TOPIC_IN=$(hass.jq "${CONFIG_PATH}" ".mqtt_topicin")
MQTT_TOPIC_OUT=$(hass.jq "${CONFIG_PATH}" ".mqtt_topicout")
MQTT_USER=$(hass.jq "${CONFIG_PATH}" ".mqtt_user")
MQTT_PASSWORD=$(hass.jq "${CONFIG_PATH}" ".mqtt_password")

MQTT_OPTS="--my-mqtt-client-id=$MQTT_CLIENTID --my-controller-url-address=$MQTT_SERVER --my-mqtt-publish-topic-prefix=$MQTT_TOPIC_OUT --my-mqtt-subscribe-topic-prefix=$MQTT_TOPIC_IN --my-mqtt-password=password --my-mqtt-user=user"

cd $APPDIR
./configure --spi-spidev-device=/dev/spidev0.0 --my-transport=$MYSGW_TRN --my-gateway=$MYSGW_TYPE $MQTT_OPTS
make -j4 && make install
sudo./bin/mysgw --daemon
