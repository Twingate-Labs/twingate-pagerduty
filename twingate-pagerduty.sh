#!/bin/bash
CONTENT_TYPE="application/json"
. /etc/twingate/twingate-pagerduty.conf
journalctl -u twingate-connector -f -n 0 | \
while read line ; do
        echo "$line" | grep "error_message"
        if [ $? = 0 ]
        then
                log="${line##*ANALYTICS }"
                curl -H ${CONTENT_TYPE} -X POST -d "$log" ${PAGERDUTY_INTEGRATION_URL}
        fi
done