# Creates users

{% for name, user in pillar.get('users', {}).items() if user.absent is not defined or not user.absent %}

{%- if user == None -%}
{%- set user = {} -%}
{%- endif -%}

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
      - group: {{name}}

xsession_{{name}}:
  file.managed:
    - name: {{home}}/.xsession
    - user: {{name}}
    - group: {{name}}
    - source: salt://files/.xsession
    - require:
      - user: {{name}}
      - group: {{name}}

oh_my_zsh_{{name}}:
  git.latest:
    - name: git://github.com/robbyrussell/oh-my-zsh.git
    - rev: master
    - target: {{home}}/.oh-my-zsh
    - user: {{name}}
    - unless: "test -d {{home}}/.oh-my-zsh"
    - onlyif: "test -d {{home}}"
    - require:
      - user: {{name}}
      - group: {{name}}
      - pkg: zsh

set_oh_my_zsh_folder_and_file_permissions_{{name}}:
  file.directory:
    - name: {{home}}/.oh-my-zsh
    - user: {{name}}
    - group: {{name}}
    - file_mode: 744
    - dir_mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - require:
      - git: oh_my_zsh_{{name}}

zshrc_{{name}}:
  file.managed:
    - name: {{home}}/.zshrc
    - source: salt://files/.zshrc
    - user: {{name}}
    - group: {{name}}
    - mode: 644
    - template: jinja
    - context:
      theme: {{user['zshrc_theme']}}
      plugins: {{user['zshrc_plugins']}}
    - require:
      - git: oh_my_zsh_{{name}}
      - file: set_oh_my_zsh_folder_and_file_permissions_{{name}}
{% endfor %}
