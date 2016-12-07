##motd
motd:
  file.managed:
     - name: /root/motd.sh
     - source: salt://files/system/motd.sh
     - user: root
     - mode: 755
  cmd.run:
    - name: /root/motd.sh
    - user: root
    - watch:
      - file: /root/motd.sh
###vim
vim:
  pkg:
    - installed
    - name: vim-enhanced
  file.managed:
    - name: /root/.vimrc
    - source: salt://files/system/vimrc
    - user: root
    - mode: 644
    - require:
      - pkg: vim
###firewalld
firewalld:
  service:
    - dead
  pkg:
    - removed
    - name: firewalld

#chronyd#
chronyd:
  service.running:
    - name: chronyd
    - enable: True
