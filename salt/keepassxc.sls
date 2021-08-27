# Install KeepassXC directly from Ubuntu PPA
#
# see:
#   https://keepassxc.org/download/#linux
#   https://launchpad.net/~phoerious/+archive/ubuntu/keepassxc
#
# note: there is a bug as documented here:
#   https://github.com/saltstack/salt/issues/59065
#   so I am using a workaround until is fixed.

# keepassxc:
#   pkgrepo.managed:
#     - humanname: KeePassXC Password Manager (official upstream PPA)
#     - ppa: phoerious/keepassxc
#   pkg.latest:
#     - name: keepassxc
#     - refresh: True

keepassxc:
  pkgrepo.managed:
    - humanname: KeePassXC Password Manager (official upstream PPA)
    - name: deb http://ppa.launchpad.net/phoerious/keepassxc/ubuntu hirsute main
    - file: /etc/apt/sources.list.d/keepassxc.list
    - gpgcheck: 1
    - keyid: D89C66D0E31FEA2874EBD20561922AB60068FCD6
    - keyserver: keyserver.ubuntu.com
  pkg.latest:
    - name: keepassxc
    - refresh: True
