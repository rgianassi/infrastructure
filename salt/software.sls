software_installed:
  pkg.latest:
    - names:
      {% for configuration, packages in pillar.get('software', {}).items() %}
      {% for package in packages %}
      - {{ package }}
      {% endfor %}
      {% endfor %}
