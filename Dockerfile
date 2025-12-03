# Home Assistant required build argument (Supervisor will supply this)
ARG BUILD_FROM
FROM ${BUILD_FROM}

LABEL \
    io.hass.name="SolarSynkV3" \
    io.hass.description="SolarSynk V3 Add-on" \
    io.hass.type="addon" \
    maintainer="Thomas Stumke"

# Install requirements for add-on
# Add retry logic because Alpine CDN sometimes returns "temporary error (try again later)"
RUN set -eux; \
    for i in 1 2 3 4 5; do \
      apk update && break || sleep 5; \
    done; \
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
