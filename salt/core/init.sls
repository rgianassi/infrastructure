core-packages:
  pkg.installed:
    - names:
      - bash
      - git
      - htop
      - keepassxc
      - tree
      - zsh

true_home:
  file.directory:
    - name: ~roberto/true_home/repo
    - user: roberto
    - group: roberto
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
      - ignore_dirs

infrastructure_repository:
  git.latest:
    - name: ssh://git@github.com/rgianassi/infrastructure.git
    - target: /home/roberto/true_home/repo/infrastructure/main
    - identity: /home/roberto/.ssh/id_ed25519_github
    - rev: main
    - branch: main
    - force_reset: True
    - user: roberto
    - require:
      - pkg: git

infrastructure_user_name:
  git.config_set:
    - name: user.name
    - value: rgianassi
    - repo: /home/roberto/true_home/repo/infrastructure/main

infrastructure_user_email:
  git.config_set:
    - name: user.email
    - value: roberto.gianassi+github.com@gmail.com
    - repo: /home/roberto/true_home/repo/infrastructure/main

