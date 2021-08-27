# Mantains salt master repository up to date.
#

github.com:
  ssh_known_hosts:
    - present
    - user: root
    - enc: ssh-rsa
    - fingerprint: nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8
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
