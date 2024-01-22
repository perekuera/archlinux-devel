FROM archlinux:latest

LABEL maintainer="perekuera@gmail.com"

ARG UUID=1000
ARG GUID=$UUID
ARG USERNAME=devel

ENV UID=$UUID
ENV GID=$GUID
ENV USER=$USERNAME
ENV TZ="Europe/Madrid"

#RUN pacman -Syyu --noconfirm --needed git sudo

RUN groupadd -g "${GUID}" "${USERNAME}"; \
    useradd -ms /bin/bash "${USERNAME}" -u "${UUID}" -g "${USERNAME}" -g "${GUID}"; \
    echo "ALL ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${USERNAME}"; \
    chmod 0440 "/etc/sudoers.d/${USERNAME}"; \
    pacman -Syyu; \
    pacman -S --noconfirm git nodejs-lts-iron npm

# curl wget

USER $USERNAME

RUN git config --global init.defaultBranch main

WORKDIR /home/$USERNAME
