#!/bin/bash


CONTENT_TYPE="application/json"
URL="https://events.pagerduty.com/v2/enqueue"
ROUTING_KEY="xxxxx"

journalctl -u twingate-connector -f -n 0 | \
while read line ; do
        echo "$line" | grep "error_message"
        if [ $? = 0 ]
        then
#               log="${line//\"/\\\"}" 
                curl -H ${CONTENT_TYPE} -X POST -d '{"payload": {"summary": "Error is found in Twingate Analytic logs","source": "testsource","severity": "info"},"routing_key": "'${ROUTING_KEY}'","event_action": ">

        fi
done
