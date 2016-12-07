rm_other_repo:
  cmd.run: 
    - name: rm -rfv /etc/yum.repos.d/*
epel_repo:
  file.managed:
    - name: /etc/yum.repos.d/yovole_yum_openstack.repo
    - source: salt://files/openstack/yovole_yum_openstack.repo
  cmd.run:
    - name: yum clean all && yum makecache 

salt-minion:
  pkg.installed:
    - name: salt-minion
    - require:
      - file: /etc/yum.repos.d/yovole_yum_openstack.repo
  file.managed:
    - name: /etc/salt/minion
    - source: salt://files/minion/minion
    - require:
      - pkg: salt-minion
  service.running:
    - name: salt-minion
    - enable: True
    - require:
      - file: /etc/salt/minion
