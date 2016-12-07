create_database_cinder:
  cmd.run:
      - name: mysql -uroot -e "CREATE DATABASE if not exists {{ pillar['cinder']['cinder_database'] }};GRANT ALL PRIVILEGES ON {{ pillar['cinder']['cinder_database'] }}.* TO '{{ pillar['cinder']['cinder_db_user'] }}'@'localhost' IDENTIFIED BY '{{ pillar['cinder']['cinder_db_passwd'] }}'; GRANT ALL PRIVILEGES ON {{ pillar['cinder']['cinder_database'] }}.* TO '{{ pillar['cinder']['cinder_db_user'] }}'@'{{ pillar['cinder']['controller_hostname'] }}' IDENTIFIED BY '{{ pillar['cinder']['cinder_db_passwd'] }}';GRANT ALL PRIVILEGES ON {{ pillar['cinder']['cinder_database'] }}.* TO '{{ pillar['cinder']['cinder_db_user'] }}'@'%' IDENTIFIED BY '{{ pillar['cinder']['cinder_db_passwd'] }}'"


/root/openstack/cinder-keystone.sh:
  file.managed:
    - source: salt://openstack/cinder/cinder-keystone.sh
    - user: root
    - mode: 755
    - template: jinja
    - defaults:
      controller_hostname: {{ pillar['cinder']['controller_hostname'] }}
      cinder_keystone_passwd: {{ pillar['cinder']['cinder_keystone_passwd'] }}

  cmd.run:
    - name: /root/openstack/cinder-keystone.sh
    - require:
      - file: /root/openstack/cinder-keystone.sh
