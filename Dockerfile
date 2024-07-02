FROM ubuntu:latest

RUN apt update
RUN apt install -y python3 python3-pip gcc
RUN pip install --break-system-packages authenticator bottle protobuf qrcode Pillow

COPY extract_otp_secret_keys /usr/bin/extract_otp_secret_keys
COPY server /usr/bin/server
COPY ThirdParty/extract_otp_secret_keys /extract_otp_secret_keys

RUN ["chmod", "+x", "/usr/bin/server"]

ENTRYPOINT ["/usr/bin/server"]
CMD [""]
