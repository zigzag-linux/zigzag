# zigzag-configuration

Configuration files (Ansible Playbooks) preserving default configuration of Zigzag Linux images.

## Building

This repository is integrated with an [OBS service](https://build.opensuse.org/package/show/home:mkrwc:zigzag/zigzag-configuration) which automatically fetches spec file and builds RPM package. To bootstrap it locally run:

        $ make install

## Running

To run ansible playbooks locally and thus replace configuration with the defaults, run:

        $ write-zigzag-configuration
