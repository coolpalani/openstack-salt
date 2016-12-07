openstack-nova-compute:
  pkg.installed:
    - name: openstack-nova-compute
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://openstack/nova/nova-compute.conf
    - user: root
    - group: nova
    - mode: 640
    - template: jinja
    - defaults:
      my_server: {{ pillar['nova']['mysql_server'] }}
      controller_hostname: {{ pillar['controller']['controller'] }}
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
      virt_type: {{ pillar['nova']['virt_type'] }}

  service.running:
    - name: openstack-nova-compute
    - enable: True
    - restart: True
    - watch:
      - file: /etc/nova/nova.conf

libvirtd:
  service.running:
    - name: libvirtd
    - enable: True
    - restart: True
    - watch:
      - file: /etc/nova/nova.conf

