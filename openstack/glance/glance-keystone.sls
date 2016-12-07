create_database_glance:
  cmd.run:
      - name: mysql -uroot -e "CREATE DATABASE if not exists {{ pillar['glance']['glance_database'] }};GRANT ALL PRIVILEGES ON {{ pillar['glance']['glance_database'] }}.* TO '{{ pillar['glance']['glance_user'] }}'@'localhost' IDENTIFIED BY '{{ pillar['glance']['glance_passwd'] }}'; GRANT ALL PRIVILEGES ON {{ pillar['glance']['glance_database'] }}.* TO '{{ pillar['glance']['glance_user'] }}'@'{{ pillar['glance']['controller_hostname'] }}' IDENTIFIED BY '{{ pillar['glance']['glance_passwd'] }}';GRANT ALL PRIVILEGES ON {{ pillar['glance']['glance_database'] }}.* TO '{{ pillar['glance']['glance_user'] }}'@'%' IDENTIFIED BY '{{ pillar['glance']['glance_passwd'] }}'"

/root/openstack/glance-keystone.sh:
  file.managed:
    - source: salt://openstack/glance/glance-keystone.sh
    - user: root
    - mode: 755
    - template: jinja
    - defaults:
      controller_hostname: {{ pillar['glance']['controller_hostname'] }}
      glance_keystone_passwd: {{ pillar['glance']['glance_keystone_passwd'] }}

  cmd.run:
    - name: /root/openstack/glance-keystone.sh
    - require:
      - file: /root/openstack/glance-keystone.sh
