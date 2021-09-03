# Mantains salt master repository up to date.
#
# note: there is a bug that makes fingerprint field to not work.
#   I found a workaround in https://github.com/saltstack/salt/issues/46152
#   In practice, with:
#   echo -n 'nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8' | base64 -d 2>/dev/null | od -A n -t x1 | xargs echo | sed 's/\ *//g;s/\(..\)/\1:/g;s/:$//'
#   is possible to compute the fingerprint in hex format which makes Python happy.
#   9d:38:5b:83:a9:17:52:92:56:1a:5e:c4:d4:81:8e:0a:ca:51:a2:64:f1:74:20:11:2e:f8:8a:c3:a1:39:49:8f
#   Enjoy!
#

github.com:
  ssh_known_hosts:
    - present
    - user: root
    - enc: ssh-rsa
    - fingerprint: 9d:38:5b:83:a9:17:52:92:56:1a:5e:c4:d4:81:8e:0a:ca:51:a2:64:f1:74:20:11:2e:f8:8a:c3:a1:39:49:8f
    - fingerprint_hash_type: sha256

saltmaster_repository:
  git.latest:
    - name: ssh://git@github.com/rgianassi/infrastructure.git
    - rev: main
    - target: /srv/main
    - branch: main
    - force_reset: True
    - identity: /root/.ssh/id_ed25519_infrastructure
    - require:
      - pkg: git
      - ssh_known_hosts: github.com
  file.absent:
    - name: /srv/salt
