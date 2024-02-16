ARG BUILD_FROM
FROM $BUILD_FROM

COPY run.sh /
RUN chmod a+x /run.sh

RUN apk add --no-cache \
    autossh

CMD [ "/run.sh" ]
