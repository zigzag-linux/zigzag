FROM opensuse/leap:15.3

RUN zypper ar obs://Virtualization:/Appliances:/Builder/openSUSE_Leap_\$releasever/ kiwi
RUN zypper --gpg-auto-import-keys up -y
RUN zypper in -y python3-kiwi kiwi-systemdeps-iso-media

COPY mkiso.sh /usr/local/bin/mkiso
WORKDIR /kiwi
