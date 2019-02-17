#!/bin/sh

PARAMS_PRE="-l 15000 -e 5 -i $INTERVAL -c "
USER_CMD="echo \"setreading $FHEM_DEVICE $FHEM_READING %d\" | nc -q0 -w$CONNECT_TIMEOUT $FHEM_HOST $FHEM_PORT"

exec /airsensor/airsensor $PARAMS_PRE "$USER_CMD"
