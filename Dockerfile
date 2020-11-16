ARG version=4.6-1-jdk11
FROM jenkins/agent:$version

ARG version
LABEL Description="This is a base image, which allows connecting Jenkins agents via JNLP protocols" Vendor="Jenkins project" Version="$version"

ARG user=jenkins

USER root
RUN curl https://raw.githubusercontent.com/jenkinsci/docker-inbound-agent/master/jenkins-agent -o jenkins-agent && cp jenkins-agent /usr/local/bin/jenkins-agent
RUN apt-get update
RUN apt install curl php-cli php-mbstring php-xml php-gd php-zip git jq unzip php- -y
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=1.10.17
RUN chmod +x /usr/local/bin/jenkins-agent &&\
    ln -s /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-slave
USER ${user}

ENTRYPOINT ["jenkins-agent"]