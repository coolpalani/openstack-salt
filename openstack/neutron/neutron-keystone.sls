create_database_neutron:
  cmd.run:
      - name: mysql -uroot -e "CREATE DATABASE if not exists {{ pillar['neutron']['neutron_database'] }};GRANT ALL PRIVILEGES ON {{ pillar['neutron']['neutron_database'] }}.* TO '{{ pillar['neutron']['neutron_db_user'] }}'@'localhost' IDENTIFIED BY '{{ pillar['neutron']['neutron_db_passwd'] }}'; GRANT ALL PRIVILEGES ON {{ pillar['neutron']['neutron_database'] }}.* TO '{{ pillar['neutron']['neutron_db_user'] }}'@'{{ pillar['neutron']['controller_hostname'] }}' IDENTIFIED BY '{{ pillar['neutron']['neutron_db_passwd'] }}';GRANT ALL PRIVILEGES ON {{ pillar['neutron']['neutron_database'] }}.* TO '{{ pillar['neutron']['neutron_db_user'] }}'@'%' IDENTIFIED BY '{{ pillar['neutron']['neutron_db_passwd'] }}'"


/root/openstack/neutron-keystone.sh:
  file.managed:
    - source: salt://openstack/neutron/neutron-keystone.sh
    - user: root
    - mode: 755
    - template: jinja
    - defaults:
      controller_hostname: {{ pillar['neutron']['controller_hostname'] }}
      neutron_keystone_passwd: {{ pillar['neutron']['neutron_keystone_passwd'] }}

  cmd.run:
    - name: /root/openstack/neutron-keystone.sh
    - require:
      - file: /root/openstack/neutron-keystone.sh
