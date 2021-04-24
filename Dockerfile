FROM node:14.16.1-alpine AS builder

WORKDIR /app

RUN npm i -g gulp
RUN apk update && apk add git

ARG ARIANG_VERSION
ENV ARIANG_VERSION={ARIANG_VERSION}
RUN echo "ARIANG_VERSION: ${ARIANG_VERSION}"

RUN git clone --depth 1 -b ${ARIANG_VERSION} https://github.com/mayswind/AriaNg.git
RUN cd AriaNg && npm i && gulp clean build && rm -rf node_modules 


FROM nginx:1.17.6-alpine

WORKDIR /app

RUN apk update && apk add --no-cache aria2

COPY --from=builder /app/AriaNg/dist /usr/share/nginx/html

COPY aria2.conf /etc/aria2/aria2.conf

COPY ./entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]