# Install KeepassXC directly from Ubuntu PPA
#
# see:
#   https://keepassxc.org/download/#linux
#   https://launchpad.net/~phoerious/+archive/ubuntu/keepassxc
#

keepassxc:
  pkgrepo.managed:
    - humanname: KeePassXC Password Manager (official upstream PPA)
    - ppa: phoerious/keepassxc
  pkg.latest:
    - name: keepassxc
    - refresh: True
