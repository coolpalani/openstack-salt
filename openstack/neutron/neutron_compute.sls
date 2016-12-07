ebtables:
  pkg.installed:
    - name: ebtables
    - require:
      - pkg: openstack-neutron-linuxbridge

ipset:
  pkg.installed:
    - name: ipset
    - require:
      - pkg: openstack-neutron-linuxbridge

openstack-neutron-linuxbridge:
  pkg.installed:
    - name: openstack-neutron-linuxbridge

###################### config #############################
/etc/neutron/neutron.conf:
  file.managed:
    - source: salt://openstack/neutron/neutron_compute.conf
    - user: root
    - group: neutron
    - mode: 640
    - template: jinja
    - defaults:
      my_server: {{ pillar['neutron']['mysql_server'] }}
      controller_server: {{ pillar['controller']['controller'] }}
      neutron_database: {{ pillar['neutron']['neutron_database'] }}
      neutron_db_user: {{ pillar['neutron']['neutron_db_user'] }}
      neutron_db_passwd: {{ pillar['neutron']['neutron_db_passwd'] }}
      rabbitmq_user: {{ pillar['rabbitmq']['rabbitmq_user'] }}
      rabbitmq_passwd: {{ pillar['rabbitmq']['rabbitmq_passwd'] }}
      neutron_keystone_passwd: {{ pillar['neutron']['neutron_keystone_passwd'] }}
      nova_keystone_passwd: {{ pillar['nova']['nova_keystone_passwd'] }}
      metadata_passwd: {{ pillar['neutron']['metadata_passwd'] }}

/etc/neutron/plugins/ml2/linuxbridge_agent.ini:
  file.managed:
    - source: salt://openstack/neutron/linuxbridge_agent_compute.ini
    - user: root
    - group: neutron
    - mode: 640
    - template: jinja
    - defaults:
      my_server: {{pillar['neutron']['mysql_server']}}

###################### service.running ##########################

neutron-linuxbridge-agent.service:
  service.running:
    - name: neutron-linuxbridge-agent.service
    - enable: True
    - restart: True
    - watch:
      - file: /etc/neutron/plugins/ml2/linuxbridge_agent.ini
      - file: /etc/neutron/neutron.conf
    - require:
      - pkg: openstack-neutron-linuxbridge
