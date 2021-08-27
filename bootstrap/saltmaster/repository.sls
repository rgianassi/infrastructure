repository_infrastructure_main:
  git.latest:
    - name: ssh://git@github.com/rgianassi/infrastructure.git
    - target: /srv/main
    - identity: /root/.ssh/id_ed25519_infrastructure
    - rev: main
    - branch: main
    - force_reset: True
    - require:
      - pkg: git
