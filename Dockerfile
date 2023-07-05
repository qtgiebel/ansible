FROM ubuntu:focal AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-add-repository -y ppa:neovim-ppa/unstable && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS pep
ARG TAGS
RUN addgroup --gid 1000 pepezee
RUN adduser --gecos pepezee --uid 1000 --gid 1000 --disabled-password pepezee
USER pepezee
WORKDIR /home/pepezee

FROM pep
COPY . .
