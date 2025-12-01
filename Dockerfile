# Home Assistant required build argument
ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.18
FROM $BUILD_FROM

LABEL \
    io.hass.name="SolarSynkV3" \
    io.hass.description="SolarSynk V3 Add-on" \
    io.hass.arch="amd64" \
    io.hass.type="addon" \
    maintainer="Thomas Stumke"

# Install requirements for add-on
RUN apk update && \
    apk add --no-cache \
        python3 \
        py3-pip \
        py3-requests \
        py3-cryptography

WORKDIR /data

# Copy data for add-on
COPY run.sh /
COPY main.py /
COPY getapi.py /
COPY gettoken.py /
COPY postapi.py /
COPY settingsmanager.py /
COPY src/ /src/

RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
