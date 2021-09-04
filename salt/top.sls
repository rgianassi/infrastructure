# The 'salt' formula is at the beginning to evaluate it first.
# The reason is that git repository update is in saltmaster formula
# and we need to update it first to apply last changes without reruns.

base:
  'salt':
    - saltmaster

  '*':
    - software
    - users

  'minion2':
    - keepassxc
    - vivaldi
