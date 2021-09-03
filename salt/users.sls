# Creates users

{% for name, user in pillar.get('users', {}).items() if user.absent is not defined or not user.absent %}

{%- if user == None -%}
{%- set user = {} -%}
{%- endif -%}

{%- set user_files = salt['pillar.get'](('users:' ~ name ~ ':user_files'), {'enabled': False}) -%}
{%- set home = user.get('home', "/home/%s" %name) -%}
{%- set user_group = name -%}

{% for group in user.get('groups', []) %}
users_{{name}}_{{group}}_group:
  group:
    - name: {{group}}
    - present
{% endfor %}

users_{{name}}_user:
  group.present:
    - name: {{user_group}}
    - gid: {{user['uid']}}
  user.present:
    - name: {{name}}
    - home: {{home}}
    - shell: {{user.get('shell')}}
    - uid: {{user['uid']}}
    - password: '{{user['password']}}'
    - fullname: '{{user['fullname']}}'
    - optional_groups:
      - {{user_group}}
      {% for group in user.get('groups', []) %}
      - {{group}}
      {% endfor %}

users_{{name}}_true_home:
  file.directory:
    - name: {{home}}/true_home/repo
    - user: {{name}}
    - group: {{name}}
    - mode: 750
    - makedirs: True
    - require:
      - user: {{name}}

{% if user_files.enabled %}
xsession_{{name}}:
  file.managed:
    - name: {{home}}/.xsession
    - source: salt://files/.xsession
    - require:
      - user: {{name}}

oh_my_zsh_{{name}}:
  git.latest:
    - name: git://github.com/robbyrussell/oh-my-zsh.git
    - target: {{home}}/.oh-my-zsh
    - require:
      - user: {{name}}
{% endif %}

{% endfor %}
