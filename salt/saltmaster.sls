saltmaster_cleanup:
  file.absent:
    - name: /srv/salt
