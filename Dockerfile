FROM node:18-alpine3.15

WORKDIR /app
COPY . /app

RUN apk update \
    && apk add bash git g++ make python3 \
    && curl -sL https://firebase.tools | bash

RUN chmod +x /app/entrypoint.sh
RUN chmod +x /app/parse_output.sh
COPY parse_output.sh /usr/local/bin/

ENTRYPOINT [ "/app/entrypoint.sh" ]

