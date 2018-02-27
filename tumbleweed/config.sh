#!/usr/bin/env/bash
#======================================
# Functions...
#--------------------------------------
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

#======================================
# Greeting...
#--------------------------------------
echo "Configure image: [$kiwi_iname]..."

#======================================
# Mount system filesystems
#--------------------------------------
baseMount

#======================================
# Setup baseproduct link
#--------------------------------------
suseSetupProduct

#======================================
# Add missing gpg keys to rpm
#--------------------------------------
suseImportBuildKey

#======================================
# SuSEconfig
#--------------------------------------
suseConfig

#======================================
# Configure Zigzag
#--------------------------------------
set -e
if [[ $kiwi_profiles == *testing* ]]; then
    sed -i 's/^testing_repo:.*/testing_repo: true/g' /usr/share/zigzag/ansible/group_vars/all.yml
fi

zigzag-write-configuration --force root
zigzag-write-configuration --force live_create
set +e

#======================================
# Remove yast if not in use
#--------------------------------------
suseRemoveYaST

#======================================
# Umount kernel filesystems
#--------------------------------------
baseCleanMount

exit 0
