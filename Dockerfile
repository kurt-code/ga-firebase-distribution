FROM node:19-alpine3.16

WORKDIR /app
COPY . /app

RUN apk update \
    && apk add bash git g++ make python3 \
    && yarn global add firebase-tools

RUN chmod +x /app/entrypoint.sh
RUN chmod +x parse_output.sh
COPY parse_output.sh /usr/local/bin/

ENTRYPOINT [ "/app/entrypoint.sh" ]

