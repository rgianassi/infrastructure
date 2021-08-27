repository_infrastructure_main:
  git.latest:
    - name: ssh://git@github.com/rgianassi/infrastructure.git
    - target: /srv/main
    - identity: /home/roberto/.ssh/id_ed25519_infrastructure
    - rev: main
    - branch: main
    - force_reset: True
    - require:
      - pkg: git

repository_infrastructure_worktrees:
  module.wait:
    module.run:
      - git.worktree_add
      - cwd: /srv/main
      - worktree_path: ../prod
      - branch: prod
      - reset_branch: True
    module.run:
      - git.worktree_add
      - cwd: /srv/main
      - worktree_path: ../dev
      - branch: dev
      - reset_branch: True
    - watch:
      - git: ssh://git@github.com/rgianassi/infrastructure.git
