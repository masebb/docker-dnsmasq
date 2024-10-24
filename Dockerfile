FROM debian:bookworm-slim AS builder
ARG version=v2.90
WORKDIR /
RUN apt update && apt upgrade -y
RUN apt install -y git build-essential
RUN git clone -b ${version} http://thekelleys.org.uk/git/dnsmasq.git 
WORKDIR /dnsmasq
RUN make
RUN make install

FROM debian:bookworm-slim
COPY --from=builder /usr/local/sbin/dnsmasq .
CMD ./dnsmasq -k --conf-file=/etc/dnsmasq.conf