FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openssh-server python3 && \
    mkdir -p /run/sshd /root/.ssh && \
    rm -rf /var/lib/apt/lists/*

# Supply your public key at build time; never copy a private key.
ARG SSH_PUBLIC_KEY
RUN test -n "$SSH_PUBLIC_KEY" && \
    printf '%s\n' "$SSH_PUBLIC_KEY" > /root/.ssh/authorized_keys && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/authorized_keys && \
    printf '\nPermitRootLogin prohibit-password\nPubkeyAuthentication yes\n' >> /etc/ssh/sshd_config

EXPOSE 22

CMD ["/bin/bash", "-c", "set -e; /usr/sbin/sshd; if [ -x /usr/bin/supervisord ]; then /usr/bin/supervisord -c /etc/supervisor/supervisord.conf; fi; exec sleep infinity"]
