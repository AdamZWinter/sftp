FROM debian:buster
MAINTAINER Adrian Dvergsdal [atmoz.net]
ARG visuspw
ARG mandspw
ARG konanpw

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN apt-get update && \
    apt-get -y install openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key* && \
    useradd -M -d /sftp -s /sbin/nologin visus && \
    echo "visus:$visuspw" | chpasswd && \
    useradd -M -d /sftp -s /sbin/nologin mands && \
    echo "mands:$mandspw" | chpasswd && \
    useradd -M -d /sftp -s /sbin/nologin konan && \
    echo "konan:$konanpw" | chpasswd

COPY files/sshd_config /etc/ssh/sshd_config
COPY files/create-sftp-user /usr/local/bin/
COPY files/entrypoint /

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
