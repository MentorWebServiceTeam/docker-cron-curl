FROM gliderlabs/alpine
RUN apk add --update \
    curl

ADD runit.sh /config/

CMD ["/config/runit.sh"]
