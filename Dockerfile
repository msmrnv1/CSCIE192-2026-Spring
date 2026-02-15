FROM mcr.microsoft.com/devcontainers/python:3.11-bullseye

COPY requirements.txt /tmp/pip-tmp/

RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt

RUN rm -f /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y openjdk-17-jre-headless ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    cd /tmp && \
    unzip awscliv2.zip && \
    ./aws/install

# Autodetect architecture and set JAVA_HOME accordingly
RUN ARCH=$(dpkg --print-architecture) && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-${ARCH}/" >> /etc/profile && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-${ARCH}/" >> /etc/bash.bashrc

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-arm64/
EXPOSE 4040