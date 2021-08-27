include:
  - core.repositories

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

