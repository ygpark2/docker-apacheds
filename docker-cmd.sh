#!/bin/sh

# Trap SIGTERM and SIGINT
trap 'bash /stop-container.sh; exit $?' TERM INT

# Configure TLS
bash /configure-tls.sh

# Start Cron
crond

# Start ApacheDS
bash bin/apacheds.sh $ADS_INSTANCE_NAME start

# Tail logs
while [ ! -f instances/$ADS_INSTANCE_NAME/log/apacheds.out ]; do sleep 1; done
tail -f instances/$ADS_INSTANCE_NAME/log/apacheds.out &

# Wait for signal
while true; do sleep 1; done
