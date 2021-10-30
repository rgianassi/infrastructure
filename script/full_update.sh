#!/bin/bash

#
# Full updates all minions.
# Assumes (checkout|deploy).sh script has already run.
#

# Unset variables are errors.
set -o nounset


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
# update.
#

# Fully update all minions.
salt '*' cmd.run 'apt update'
salt '*' cmd.run 'apt full-upgrade -y'
salt '*' cmd.run 'apt autoremove -y'
salt '*' cmd.run 'apt autoclean'

echo "" >&2
echo "******************************************************************************" >&2
echo "Full update completed." >&2
echo "******************************************************************************" >&2
echo "" >&2

exit 0
