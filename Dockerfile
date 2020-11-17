ARG version=4.3-4
FROM jenkins/inbound-agent:$version

ARG version
LABEL Description="This is a base image, which allows connecting Jenkins agents via JNLP protocols" Vendor="Jenkins project" Version="$version"

ARG user=jenkins

USER root
RUN apt-get update
RUN apt install curl php-cli php-mbstring php-xml php-gd php-zip git jq unzip php- -y
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=1.10.17
USER ${user}

ENTRYPOINT ["jenkins-agent"]