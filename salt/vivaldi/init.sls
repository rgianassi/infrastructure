# Install Vivaldi Browser
#
# see:
#   https://help.vivaldi.com/desktop/install-update/manual-setup-vivaldi-linux-repositories/
#

vivaldi_browser_repository:
  pkgrepo.managed:
    - humanname: Vivaldi Browser
    - name: deb https://repo.vivaldi.com/archive/deb/ stable main
    - file: /etc/apt/sources.list.d/vivaldi-browser.list
    - gpgcheck: 1
    - key_url: https://repo.vivaldi.com/archive/linux_signing_key.pub

vivaldi-stable:
  pkg.installed:
    - require:
      - pkgrepo: vivaldi_browser_repository

