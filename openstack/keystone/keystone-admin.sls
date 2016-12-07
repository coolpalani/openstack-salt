keystone-key:
  file.managed:
    - name: /root/openstack/keystone-admin.sh
    - source: salt://openstack/keystone/keystone-admin.sh
    - user: root
    - mode: 755
    - template: jinja
    - defaults:
      controller_hostname: {{ pillar['keystone']['controller_hostname'] }}
      admin_passwd: {{ pillar['keystone']['admin_passwd'] }}
      demo_passwd: {{ pillar['keystone']['demo_passwd'] }}
  cmd.run:
    - name: /root/openstack/keystone-admin.sh

/root/openstack/admin-openrc:
  file.managed:
    - source: salt://openstack/keystone/admin-openrc
    - template: jinja
    - defaults:
      controller_hostname: {{ pillar['keystone']['controller_hostname'] }}
      admin_passwd: {{ pillar['keystone']['admin_passwd'] }}
      demo_passwd: {{ pillar['keystone']['demo_passwd'] }}


/root/openstack/demo-openrc:
  file.managed:
    - source: salt://openstack/keystone/demo-openrc
    - template: jinja
    - defaults:
      controller_hostname: {{ pillar['keystone']['controller_hostname'] }}
      admin_passwd: {{ pillar['keystone']['admin_passwd'] }}
      demo_passwd: {{ pillar['keystone']['demo_passwd'] }}
