#!/bin/bash

CONTENT_TYPE="application/json"
URL="https://events.pagerduty.com/v2/enqueue"
ROUTING_KEY="xxxxx"

curl -H ${CONTENT_TYPE} -X POST -d '{"payload": {"summary": "Twingate Analytics Error","source": "testsource","severity": "info"},"routing_key": "'${ROUTING_KEY}'","event_action": "trigger"}' ${URL}
