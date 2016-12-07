openstack-nova-api:
  pkg.installed:
    - name: openstack-nova-api
  cmd.run:
    - name: chown -R nova. /var/log/nova/

openstack-nova-conductor:
  pkg.installed:
    - name: openstack-nova-conductor

openstack-nova-console:
  pkg.installed:
    - name: openstack-nova-console 

openstack-nova-novncproxy:
  pkg.installed:
    - name: openstack-nova-novncproxy

openstack-nova-scheduler:
  pkg.installed:
    - name: openstack-nova-scheduler

/etc/nova/nova.conf:
  file.managed:
    - source: salt://openstack/nova/nova.conf
    - user: root
    - group: nova
    - mode: 640
    - template: jinja
    - require:
      - pkg: openstack-nova-api
    - defaults:
      my_server: {{ pillar['nova']['mysql_server'] }}
      controller_hostname: {{ pillar['nova']['controller_hostname'] }}
      nova_database: {{ pillar['nova']['nova_database'] }}
      nova_db_user: {{ pillar['nova']['nova_db_user'] }}
      nova_db_passwd: {{ pillar['nova']['nova_db_passwd'] }}
      nova_api_database: {{ pillar['nova']['nova_api_database'] }}
      nova_api_db_user: {{ pillar['nova']['nova_api_db_user'] }}
      nova_api_db_passwd: {{ pillar['nova']['nova_api_db_passwd'] }}
      rabbitmq_user: {{ pillar['rabbitmq']['rabbitmq_user'] }}
      rabbitmq_passwd: {{ pillar['rabbitmq']['rabbitmq_passwd'] }}
      nova_keystone_passwd: {{ pillar['nova']['nova_keystone_passwd'] }}
      neutron_keystone_passwd: {{ pillar['neutron']['neutron_keystone_passwd'] }}
      metadata_passwd: {{ pillar['neutron']['metadata_passwd'] }}

rsync_nova_db:
  cmd.run: 
    - name: su -s /bin/sh -c "nova-manage api_db sync" nova && su -s /bin/sh -c "nova-manage db sync" nova
    - require:
      - file: /etc/nova/nova.conf


openstack-nova-api-service:
  service.running:
    - name: openstack-nova-api
    - enable: True
    - restart: True
    - watch:
      - file: /etc/nova/nova.conf
    - require:
      - file: /etc/nova/nova.conf


openstack-nova-conductor-service:
  service.running:
    - name: openstack-nova-conductor
    - enable: True
    - restart: True
    - watch:
      - file: /etc/nova/nova.conf
    - require:
      - file: /etc/nova/nova.conf

openstack-nova-console-service:
  service.running:
    - name: openstack-nova-console 
    - enable: True
    - restart: True
    - watch:
      - file: /etc/nova/nova.conf
    - require:
      - file: /etc/nova/nova.conf

openstack-nova-novncproxy-service:
  service.running:
    - name: openstack-nova-novncproxy
    - enable: True
    - restart: True
    - watch:
      - file: /etc/nova/nova.conf
    - require:
      - file: /etc/nova/nova.conf

openstack-nova-scheduler-service:
  service.running:
    - name: openstack-nova-scheduler
    - enable: True
    - restart: True
    - watch:
      - file: /etc/nova/nova.conf
    - require:
      - file: /etc/nova/nova.conf

openstack-nova-consoleauth-service:
  service.running:
    - name: openstack-nova-consoleauth.service
    - enable: True
    - restart: True
    - watch:
      - file: /etc/nova/nova.conf
    - require:
      - file: /etc/nova/nova.conf
