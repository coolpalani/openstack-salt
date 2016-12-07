create_database_keystone:
  cmd.run:
    - name: mysql -uroot -e "CREATE DATABASE if not exists {{ pillar['keystone']['keystone_database'] }};GRANT ALL PRIVILEGES ON {{ pillar['keystone']['keystone_database'] }}.* TO '{{ pillar['keystone']['keystone_user'] }}'@'localhost' IDENTIFIED BY '{{ pillar['keystone']['keystone_passwd'] }}'; GRANT ALL PRIVILEGES ON {{ pillar['keystone']['keystone_database'] }}.* TO '{{ pillar['keystone']['keystone_user'] }}'@'{{ pillar['keystone']['controller_hostname'] }}' IDENTIFIED BY '{{ pillar['keystone']['keystone_passwd'] }}';GRANT ALL PRIVILEGES ON {{ pillar['keystone']['keystone_database'] }}.* TO '{{ pillar['keystone']['keystone_user'] }}'@'%' IDENTIFIED BY '{{ pillar['keystone']['keystone_passwd'] }}';"
openstack-keystone:
  pkg.installed:
    - name: openstack-keystone
  file.managed:
    - name: /etc/keystone/keystone.conf
    - source: salt://openstack/keystone/keystone.conf
    - mode: 640
    - user: root
    - group: keystone
    - template: jinja
    - defaults:
      keystone_database: {{ pillar['keystone']['keystone_database'] }}
      keystone_user: {{ pillar['keystone']['keystone_user'] }}
      keystone_passwd: {{ pillar['keystone']['keystone_passwd'] }}
      controller_hostname: {{ pillar['keystone']['controller_hostname'] }}
      ADMIN_TOKEN: {{ pillar['keystone']['ADMIN_TOKEN'] }}
  cmd.run:
    - name: su -s /bin/sh -c "keystone-manage db_sync" keystone && keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone

mod_wsgi:
  pkg.installed:
    - name: mod_wsgi
    - require:
      - pkg: httpd
apache:
  pkg.installed:
    - name: httpd
  service.running:
    - name: httpd
    - enable: True
    - restart: True
    - watch:
      - file: /etc/httpd/conf/httpd.conf
      - file: /etc/httpd/conf.d/wsgi-keystone.conf
    - require:
      - file: /etc/httpd/conf/httpd.conf
      - file: /etc/httpd/conf.d/wsgi-keystone.conf

memcache_keystone:
  service.running:
    - name: memcached
    - restart: True
    - watch:
      - file: /etc/httpd/conf/httpd.conf
      - file: /etc/httpd/conf.d/wsgi-keystone.conf

/etc/httpd/conf.d/wsgi-keystone.conf:
  file.managed:
    - source: salt://openstack/keystone/wsgi-keystone.conf
    - require:
      - pkg: httpd

/etc/httpd/conf/httpd.conf:
  file.managed:
    - source: salt://openstack/keystone/httpd.conf
    - template: jinja
    - require:
      - pkg: httpd
    - defaults:
      controller_hostname: {{ pillar['keystone']['controller_hostname'] }}
