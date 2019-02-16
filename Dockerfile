FROM ubuntu:bionic AS builder

RUN apt-get update;apt-get install -y \
	build-essential \
	git \
	libusb-dev

RUN git clone --branch 1.0.0 https://github.com/verybadsoldier/airsensor.git
RUN cd airsensor;make


FROM ubuntu:bionic

RUN apt-get update && apt-get install -y \
  libusb-0.1-4 \
  netcat

RUN mkdir /airsensor
COPY --from=builder airsensor/airsensor /airsensor/airsensor
COPY run_airsensor.sh /airsensor/run_airsensor.sh
RUN chmod 777 /airsensor/run_airsensor.sh;chmod +x /airsensor/airsensor

ENV FHEM_HOST=minion FHEM_PORT=7072 FHEM_DEVICE=fl_airSensor FHEM_READING=airQuality
ENV PATH=/airsensor;$PATH

CMD run_airsensor.sh
