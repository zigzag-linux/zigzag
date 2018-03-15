FROM opensuse/tumbleweed

RUN zypper --gpg-auto-import-keys up -y
RUN zypper in -y python3-kiwi syslinux

WORKDIR /kiwi
