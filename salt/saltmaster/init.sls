include:
  - saltmaster.config
  - saltmaster.repository

saltmaster_requirements:
  pkg.installed:
    - names:
      - git
