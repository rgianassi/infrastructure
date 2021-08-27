# Create true_home for users inside home folder.
#
# note: this temporarly here, but must be moved on SLS formula for users
#   creation when available.
#

true_home:
  file.directory:
    - name: ~roberto/true_home/repo
    - user: roberto
    - group: roberto
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
      - ignore_dirs
