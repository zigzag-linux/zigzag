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
export ZIGZAG_KIWI=1

set -e
if [[ $kiwi_profiles == *devel* ]]; then
    export ZIGZAG_DEVEL=1
fi

zigzag-write-configuration --force root
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
