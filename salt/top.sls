# The 'salt' formula is at the beginning to evaluate it first.
# The reason is that git repository update is in saltmaster formula
# and we need to update it firstly to apply latest changes without reruns.
# At the moment, this strategy does not seem to work: it seems that salt
# reads the configuration from disk and execute it without applying changes
# if the configuration is updated during the run. To be investigated.
# For the moment, the only working solution is to run apply.state twice.

base:
  'salt':
    - saltmaster

  '*':
    - software
    - users

  'minion2':
    - keepassxc
    - vivaldi
