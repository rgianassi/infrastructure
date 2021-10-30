#!/bin/bash

#
# Checkouts a branch on salt folders.
# Must be run without arguments to apply updates or passing a SHA/branch to
# test that particular commit.
# Assumes bootstrap.sh script has already run.
#

# Unset variables are errors.
set -o nounset


###############################################################################
# Some helpers.
#
_THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

_SRV_REPO_DIR="$(readlink -m "$_THIS_DIR"/..)"
_SRV_DIR=${CO_SRV_DIR:-/srv}
_SRV_MAIN_DIR=${CO_SRV_MAIN_DIR:-/srv/main}

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

###############################################################################
# checkout.
#

if [ -d "${_SRV_MAIN_DIR}" ]; then
    rm -rf "${_SRV_MAIN_DIR}"
fi

# Copies repository in expected place.
cp -r "${_SRV_REPO_DIR}" "${_SRV_MAIN_DIR}"

echo "Checkout completed." >&2
echo "" >&2

exit 0
