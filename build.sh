set -ex
USERNAME=verybadsoldier
IMAGE=airsensor-fhem
docker build -t $USERNAME/$IMAGE:latest .
