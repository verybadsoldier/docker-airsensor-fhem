FROM alpine:latest AS builder

# apk install
RUN apk update && \
    apk add build-base && \
    apk add libusb-compat-dev && \
    apk add linux-headers && \    
    apk add git && \    
    rm -rf /var/cache/apk/*

RUN git clone --branch 1.0.0 https://github.com/verybadsoldier/airsensor.git
RUN cd airsensor;make


FROM alpine:latest

RUN apk update && \
    apk add libusb-compat && \
    apk add netcat-openbsd

RUN mkdir /airsensor
COPY --from=builder airsensor/airsensor /airsensor/airsensor
COPY run_airsensor.sh /airsensor/run_airsensor.sh
RUN chmod +x /airsensor/run_airsensor.sh;chmod +x /airsensor/airsensor

ENV FHEM_HOST=minion FHEM_PORT=7072 FHEM_DEVICE=fl_airSensor FHEM_READING=airQuality INTERVAL=10 \
	CONNECT_TIMEOUT=2
ENV PATH=/airsensor:$PATH

CMD run_airsensor.sh
