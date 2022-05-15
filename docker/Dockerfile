FROM opensuse/leap:15.4

RUN zypper --gpg-auto-import-keys up -y
RUN zypper in -y python3-kiwi kiwi-systemdeps-iso-media dnf

COPY mkiso.sh /usr/local/bin/mkiso
WORKDIR /kiwi
