FROM rust:1.67-buster as build

ARG BRANCH=master

WORKDIR /usr/src/

RUN apt-get update && apt-get install -y \
    gcc-arm-linux-gnueabihf \
    libc6-dev-armhf-cross \
    libasound2-dev:armhf \
    libssl-dev:armhf \
    git

RUN git clone --branch=${BRANCH} https://github.com/Spotifyd/spotifyd.git

RUN cd spotifyd && \
    rustup target add armv7-unknown-linux-gnueabihf && \
    cargo build --target=armv7-unknown-linux-gnueabihf --release

FROM arm32v7/debian:buster-slim as release

ENTRYPOINT ["/usr/bin/spotifyd", "--no-daemon"]

COPY --from=build /usr/src/spotifyd/target/armv7-unknown-linux-gnueabihf/release/spotifyd /usr/bin/
