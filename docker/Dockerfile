FROM opensuse:tumbleweed
RUN zypper ar obs://Virtualization:Appliances:Builder kiwi-ng
RUN zypper --gpg-auto-import-keys up -y
RUN zypper in -y python3-kiwi kiwi-tools
WORKDIR /kiwi
