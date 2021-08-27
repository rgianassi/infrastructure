include:
  - saltmaster.config
  - saltmaster.repository

saltmaster_requirements:
  pkg.latest:
    - names:
      - git
