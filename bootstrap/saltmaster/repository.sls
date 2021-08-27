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
