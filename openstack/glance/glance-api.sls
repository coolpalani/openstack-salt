openstack-glance:
  pkg.installed:
    - name: openstack-glance


/etc/glance/glance-api.conf:
  file.managed:
    - source: salt://openstack/glance/glance-api.conf
    - user: root
    - group: glance
    - template: jinja
    - pkg: openstack-glance
    - defaults:
      controller_hostname: {{ pillar['glance']['controller_hostname'] }}
      glance_database: {{ pillar['glance']['glance_database'] }}
      glance_user: {{ pillar['glance']['glance_user'] }}
      glance_passwd: {{ pillar['glance']['glance_passwd'] }}
      glance_keystone_passwd: {{ pillar['glance']['glance_keystone_passwd'] }}



/etc/glance/glance-registry.conf:
  file.managed:
    - source: salt://openstack/glance/glance-registry.conf
    - user: root
    - group: glance
    - template: jinja
    - pkg: openstack-glance
    - defaults:
      controller_hostname: {{ pillar['glance']['controller_hostname'] }}
      glance_database: {{ pillar['glance']['glance_database'] }}
      glance_user: {{ pillar['glance']['glance_user'] }}
      glance_passwd: {{ pillar['glance']['glance_passwd'] }}
      glance_keystone_passwd: {{ pillar['glance']['glance_keystone_passwd'] }}

rsync_glance:
  cmd.run: 
    - name: su -s /bin/sh -c "glance-manage db_sync" glance
    - require:
      - file: /etc/glance/glance-api.conf
      - file: /etc/glance/glance-registry.conf

openstack-glance-api:
  service.running:
    - name: openstack-glance-api
    - enable: True
    - restart: True
    - watch:
      - file: /etc/glance/glance-api.conf

openstack-glance-registry:
  service.running:
    - name: openstack-glance-registry
    - enable: True
    - restart: True
    - watch:
      - file: /etc/glance/glance-registry.conf
