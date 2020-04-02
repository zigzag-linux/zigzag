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
# Setup baseproduct link
#--------------------------------------
suseSetupProduct

#======================================
# Add missing gpg keys to rpm
#--------------------------------------
suseImportBuildKey

#======================================
# Configure Zigzag
#--------------------------------------
export ZIGZAG_KIWI=1

set -e
zigzag-write-configuration --force root
set +e

#======================================
# Remove yast if not in use
#--------------------------------------
suseRemoveYaST
