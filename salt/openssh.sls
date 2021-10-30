/etc/ssh/sshd_config.d/hardening.conf:
  file.managed:
    - name: /etc/ssh/sshd_config.d/hardening.conf
    - user: root
    - group: root
    - mode: 644
    - source: salt://files/etc/ssh/sshd_config.d/hardening.conf
    - require:
      - pkg: openssh-server

/etc/ssh/banner:
  file.managed:
    - name: /etc/ssh/banner
    - user: root
    - group: root
    - mode: 644
    - source: salt://files/etc/ssh/banner
    - require:
      - pkg: openssh-server

ssh:
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: openssh-server
    - watch:
      - file: /etc/ssh/sshd_config.d/hardening.conf
