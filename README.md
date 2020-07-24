# snapdrop-docker

This is a Docker Image for latest version of Snapdrop (https://snapdrop.net)

# How to Run

## CLI

```
docker run --rm -p 8080:80 seji/snapdrop-docker:latest

```

## Docker-Compose

```
version: '3'

services:

 snapdrop:
    image: seji/snapdrop-docker:latest
    container_name: snapdrop
    ports:
      - 3080:80
    networks:
      - web
    restart: unless-stopped
```
