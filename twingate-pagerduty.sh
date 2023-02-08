#!/bin/bash
CONTENT_TYPE="application/json"

if [ -z "$CONNECTOR_NAME" ]; then
        CONNECTOR_NAME=$(hostname)
fi
journalctl -u twingate-connector -f -n 0 | \
while read line ; do
        echo "$line" | grep \"error_message\"
        if [ $? = 0 ]; then
                log="${line##*ANALYTICS }"
                curl --silent --output /dev/null --show-error --fail -H ${CONTENT_TYPE} -X POST -d "$log" ${PAGERDUTY_INTEGRATION_URL}
                echo "Analytics payload sent: ${log}"
        fi
        echo "$line" | grep ": State: "
        if [ $? = 0 ]; then
                state="${line##*State: }"
                type="none"
                if [ "$state" = "Offline" ]  || [ "$state" = "Error" ] || [ "$state" = "Unrecoverable error" ]; then
                        type="trigger"
                        log="{\"log\": \"${line##*State: }\", \"connector\": \"${CONNECTOR_NAME}\", \"type\": \"${type}\", \"event\": \"Monitor\"}"
                        curl --silent --output /dev/null --show-error --fail -H ${CONTENT_TYPE} -X POST -d "$log" ${PAGERDUTY_INTEGRATION_URL}
                        echo "Service indident sent: ${log}"
                elif [ "$state" = "Online" ]; then
                        type="recover"
                        log="{\"log\": \"${line##*State: }\", \"connector\": \"${CONNECTOR_NAME}\", \"type\": \"${type}\", \"event\": \"Monitor\"}"
                        curl --silent --output /dev/null --show-error --fail -H ${CONTENT_TYPE} -X POST -d "$log" ${PAGERDUTY_INTEGRATION_URL}
                        echo "Service recovery sent: ${log}"
                fi
        fi
done