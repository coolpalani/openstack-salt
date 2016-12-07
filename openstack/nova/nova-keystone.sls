create_database_nova:
  cmd.run:
      - name: mysql -uroot -e "CREATE DATABASE if not exists {{ pillar['nova']['nova_database'] }};GRANT ALL PRIVILEGES ON {{ pillar['nova']['nova_database'] }}.* TO '{{ pillar['nova']['nova_db_user'] }}'@'localhost' IDENTIFIED BY '{{ pillar['nova']['nova_db_passwd'] }}'; GRANT ALL PRIVILEGES ON {{ pillar['nova']['nova_database'] }}.* TO '{{ pillar['nova']['nova_db_user'] }}'@'{{ pillar['nova']['controller_hostname'] }}' IDENTIFIED BY '{{ pillar['nova']['nova_db_passwd'] }}';GRANT ALL PRIVILEGES ON {{ pillar['nova']['nova_database'] }}.* TO '{{ pillar['nova']['nova_db_user'] }}'@'%' IDENTIFIED BY '{{ pillar['nova']['nova_db_passwd'] }}'"


create_database_nova_api:
  cmd.run:
      - name: mysql -uroot -e "CREATE DATABASE if not exists {{ pillar['nova']['nova_api_database'] }};GRANT ALL PRIVILEGES ON {{ pillar['nova']['nova_api_database'] }}.* TO '{{ pillar['nova']['nova_api_db_user'] }}'@'localhost' IDENTIFIED BY '{{ pillar['nova']['nova_api_db_passwd'] }}'; GRANT ALL PRIVILEGES ON {{ pillar['nova']['nova_api_database'] }}.* TO '{{ pillar['nova']['nova_api_db_user'] }}'@'{{ pillar['nova']['controller_hostname'] }}' IDENTIFIED BY '{{ pillar['nova']['nova_api_db_passwd'] }}';GRANT ALL PRIVILEGES ON {{ pillar['nova']['nova_api_database'] }}.* TO '{{ pillar['nova']['nova_api_db_user'] }}'@'%' IDENTIFIED BY '{{ pillar['nova']['nova_api_db_passwd'] }}'"

/root/openstack/nova-keystone.sh:
  file.managed:
    - source: salt://openstack/nova/nova-keystone.sh
    - user: root
    - mode: 755
    - template: jinja
    - defaults:
      controller_hostname: {{ pillar['nova']['controller_hostname'] }}
      nova_keystone_passwd: {{ pillar['nova']['nova_keystone_passwd'] }}

  cmd.run:
    - name: /root/openstack/nova-keystone.sh
    - require:
      - file: /root/openstack/nova-keystone.sh
