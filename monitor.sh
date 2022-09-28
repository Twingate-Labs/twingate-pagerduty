journalctl -u twingate-connector -f | \
while read line ; do
        echo "$line" | grep "error_message"
        if [ $? = 0 ]
        then
                sh ./create_alert.sh
        fi
done
