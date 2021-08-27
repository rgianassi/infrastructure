master_file_roots:
  file.managed:
    - name: /etc/salt/master.d/90-file-roots.conf
    - user: root
    - group: root
    - mode: 644
    - source: salt://saltmaster/files/90-file-roots.conf

master_pillar_roots:
  file.managed:
    - name: /etc/salt/master.d/91-pillar-roots.conf
    - user: root
    - group: root
    - mode: 644
    - source: salt://saltmaster/files/91-pillar-roots.conf

salt-master:
  service.running:
    - enable: True
    - watch:
      - file: master_file_roots
      - file: master_pillar_roots
