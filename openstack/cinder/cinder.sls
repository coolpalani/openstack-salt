lvm2-lvmetad:
  pkg.installed:
    - name: lvm2
  service.running:
    - name: lvm2-lvmetad
    - enable: True
    - restart: True

pvcreate:
  cmd.run:
    - name: pvcreate /dev/sdb && vgcreate cinder-volumes /dev/sdb

openstack-cinder:
  pkg.installed:
    - name: openstack-cinder
targetcli:
  pkg.installed:
    - name: targetcli

/etc/cinder/cinder.conf:
  file.managed:
    - source: salt://openstack/cinder/cinder.conf
    - user: root
    - group: cinder
    - mode: 640
    - template: jinja
    - require:
      - pkg: openstack-cinder
    - defaults:
      my_server: {{ pillar['cinder']['mysql_server'] }}
      controller_hostname: {{ pillar['cinder']['controller_hostname'] }}
      cinder_database: {{ pillar['cinder']['cinder_database'] }}
      cinder_db_user: {{ pillar['cinder']['cinder_db_user'] }}
      cinder_db_passwd: {{ pillar['cinder']['cinder_db_passwd'] }}
      rabbitmq_user: {{ pillar['rabbitmq']['rabbitmq_user'] }}
      rabbitmq_passwd: {{ pillar['rabbitmq']['rabbitmq_passwd'] }}
      cinder_keystone_passwd: {{ pillar['cinder']['cinder_keystone_passwd'] }}

rsync_db_cinder:
  cmd.run:
    - name: /bin/sh -c "cinder-manage db sync" cinder

openstack-cinder-api:
  service.running:
    - name: openstack-cinder-api
    - enable: True
    - restart: True
    - watch:
      - file: /etc/cinder/cinder.conf

openstack-cinder-scheduler:
  service.running:
    - name: openstack-cinder-scheduler
    - enable: True
    - restart: True
    - watch:
      - file: /etc/cinder/cinder.conf

openstack-cinder-volume:
  service.running:
    - name: openstack-cinder-volume
    - enable: True
    - restart: True
    - watch:
      - file: /etc/cinder/cinder.conf

target:
  service.running:
    - name: target
    - enable: True
    - restrt: True
    - watch:
      - file: /etc/cinder/cinder.conf
