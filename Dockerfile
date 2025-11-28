FROM alpine:latest

RUN apk add --no-cache wget unzip openssl

WORKDIR /app

RUN wget -q https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip -q Xray-linux-64.zip && \
    chmod +x xray && \
    rm Xray-linux-64.zip

RUN openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/CN=mda.digicelgroup.com" 2>/dev/null

COPY config.json .

EXPOSE 10000

CMD ["./xray", "run", "-config", "config.json"]
