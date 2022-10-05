!/bin/bash
CONTENT_TYPE="application/json"
URL="xxxxx"
ROUTING_KEY="xxxxx"

journalctl -u twingate-connector -f -n 0 | \
while read line ; do
        echo "$line" | grep "error_message"
        if [ $? = 0 ]
        then
                log="${line##*ANALYTICS }"
                curl -H ${CONTENT_TYPE} -X POST -d "$log" ${URL}
        fi
done
