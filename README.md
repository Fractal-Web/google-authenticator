# Prebuilt image

You can use a prebuilt image like this:

```yaml
version: "3.7"

services:
  google-authenticator:
    image: meowlaika/google-authenticator
    volumes:
      - ./authenticator/authenticator:/root/.authenticator/
    ports:
      - "127.0.0.1:48080:8080"
```

```sh
docker compose up -d
docker compose exec google-authenticator bash

authenticator add Google:youremail@gmail.com
```

The OTP can be queried like this:

```sh
curl -XPOST -F passphrase=123456 http://localhost:48080/login
```

# Google Authenticator container

A Docker container with [Google Authenticator](https://pypi.org/project/authenticator/) to stop being dependent on a cell phone. Import your existing tokens with CLI and access the codes with CLI or a minimalistic web interface.

## Is it secure or not?

In principle, the main purpose of 2FA is to have the second factor of authentication on a _different_ device. It does not imply this device must necessarily be a cell phone. You can put 2FA on another thrusted computer, preferably phisically located in a different city or country. Such strategy could actually make your 2FA more secure than the phone, which could be broken or stolen.

## No warranty

The security risks are your own. Be wise and do your own research.

## Usage

Clone together with submodules:

```
git clone --recurse-submodules git@github.com:dmikushin/google-authenticator.git
```

Start the container:

```
docker build -t google-authenticator .
docker-compose up -d
docker-compose exec google-authenticator sh
```

Inside the container:

```
authenticator add Google:youremail@gmail.com
```

You will need to hand in two things:

1. A passphrase, which will be used to encrypt the token in the container (do not set an empty passphrase, otherwise the program will silently abort!)
2. A shared key, which connects your token and the authorization authority (e.g. Google) into a thrust ring. The shared key could be [extracted](https://github.com/scito/extract_otp_secrets#with-external-qr-decoder-app-from-text-files) from the authenticator app, using [a nice tool](https://github.com/scito/extract_otp_secret_keys).

Once the token is added, it could be used normally:

```
authenticator generate
```

or via the web interface at http://localhost:48080
