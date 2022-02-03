master_file_roots:
  file.managed:
    - name: /etc/salt/master.d/file-roots.conf
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://saltmaster/files/file-roots.conf

master_pillar_roots:
  file.managed:
    - name: /etc/salt/master.d/pillar-roots.conf
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://saltmaster/files/pillar-roots.conf
