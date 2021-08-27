#!/bin/bash

#
# Runs initial salt stack bootstrap on a freshly installed system.
# Must be run only once on salt master.
# This script cleanups after itself.
#

# Unset variables are errors.
set -o nounset


###############################################################################
# Some helpers.
#
_THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

_BOOTSTRAP_DIR="$(readlink -m "$_THIS_DIR"/../bootstrap)"
_SRV_DIR=${BS_SRV_DIR:-/srv}
_SRV_BOOTSTRAP_DIR=${BS_SRV_BOOTSTRAP_DIR:-/srv/bootstrap}
_SRV_SALT_DIR=${BS_SRV_SALT_DIR:-/srv/salt}
_SRV_MAIN_DIR=${BS_SRV_MAIN_DIR:-/srv/main}

_FILE_ROOTS_FILE=${BS_FILE_ROOTS_FILE:-/etc/salt/master.d/90-file-roots.conf}
_PILLAR_ROOTS_FILE=${BS_PILLAR_ROOTS_FILE:-/etc/salt/master.d/91-pillar-roots.conf}

_SALT_MASTER_SERVICE=${BS_SALT_MASTER_SERVICE:-salt-master}

###############################################################################
# Runs some sanity checks.
#

# Paranoia.
if [ -f /usr/xpg4/bin/id ]; then
    whoami='/usr/xpg4/bin/id -un'
else
    whoami='whoami'
fi

# Must be root.
if [ "$($whoami)" != "root" ]; then
    echo 'This script must be run with root privileges' >&2
    exit 1
fi

# The salt-master service must be enabled.
if [ "$(systemctl is-enabled "${_SALT_MASTER_SERVICE}")" != "enabled" ]; then
    echo "The salt-master service is not enabled. Is salt master installed?" >&2
    exit 1
fi

# Updates system if needed.
apt update && apt upgrade -y

# After update reboot must not be required.
if [ -f /var/run/reboot-required ]; then
    echo "A reboot is required in order to proceed with the bootstrap." >&2
    echo "Please reboot and re-run this script to finish the bootstrap." >&2
    exit 1
fi

###############################################################################
# bootstrap.
#

# Installs git.
apt install -y git

# Stops salt master service.
systemctl stop salt-master

# Cleanups previous runs if any.
if [ -f "${_FILE_ROOTS_FILE}" ]; then
    rm -f "${_FILE_ROOTS_FILE}"
fi

if [ -f "${_PILLAR_ROOTS_FILE}" ]; then
    rm -f "${_PILLAR_ROOTS_FILE}"
fi

if [ -d "${_SRV_SALT_DIR}" ]; then
    rm -rf "${_SRV_SALT_DIR}"
fi

if [ -d "${_SRV_MAIN_DIR}" ]; then
    rm -rf "${_SRV_MAIN_DIR}"
fi

# Copies bootstrap configuration in standard place.
cp -r "${_BOOTSTRAP_DIR}"     "${_SRV_DIR}"
mv    "${_SRV_BOOTSTRAP_DIR}" "${_SRV_SALT_DIR}"

# Starts service to apply bootstrap state.
systemctl daemon-reload
systemctl start salt-master

# Runs the initial bootstrap.
salt 'salt' state.apply

# Cleanups the initial bootstrap.
rm -rf "${_SRV_SALT_DIR}"

# Reconfigure the service
systemctl stop salt-master
systemctl daemon-reload
systemctl start salt-master

# Runs the "real" bootstrap.
salt '*' state.apply

echo "Bootstrap completed." >&2
echo "" >&2

exit 0
