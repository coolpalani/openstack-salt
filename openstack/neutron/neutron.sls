openstack-neutron-ml2:
  pkg.installed:
    - name: openstack-neutron-ml2
    - require:
      - pkg: openstack-neutron

ebtables:
  pkg.installed:
    - name: ebtables
    - require:
      - pkg: openstack-neutron

openstack-neutron:
  pkg.installed:
    - name: openstack-neutron

openstack-neutron-linuxbridge:
  pkg.installed:
    - name: openstack-neutron-linuxbridge
    - require:
      - pkg: openstack-neutron

############################config################################

/etc/neutron/neutron.conf:
  file.managed:
    - source: salt://openstack/neutron/neutron.conf
    - user: root
    - group: neutron
    - mode: 640
    - template: jinja
    - defaults:
      my_server: {{ pillar['neutron']['mysql_server'] }}
      controller_hostname: {{ pillar['neutron']['controller_hostname'] }}
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
    - source: salt://openstack/neutron/linuxbridge_agent.ini
    - user: root
    - group: neutron
    - mode: 640
    - template: jinja
    - defaults:
      my_server: {{pillar['neutron']['mysql_server']}}

/etc/neutron/dhcp_agent.ini:
  file.managed:
    - source: salt://openstack/neutron/dhcp_agent.ini
    - user: root
    - group: neutron
    - mode: 640

/etc/neutron/metadata_agent.ini:
  file.managed:
    - source: salt://openstack/neutron/metadata_agent.ini
    - user: root
    - group: neutron
    - mode: 640
    - template: jinja
    - defaults:
      controller_hostname: {{ pillar['neutron']['controller_hostname'] }}
      metadata_passwd: {{ pillar['neutron']['metadata_passwd'] }}

/etc/neutron/plugins/ml2/ml2_conf.ini:
  file.managed:
    - source: salt://openstack/neutron/ml2_conf.ini
    - user: root
    - group: neutron
    - mode: 640

/etc/neutron/plugin.ini:
  file.symlink:
    - target: /etc/neutron/plugins/ml2/ml2_conf.ini

/etc/neutron/l3_agent.ini:
  file.managed:
    - source: salt://openstack/neutron/l3_agent.ini
    - user: root
    - group: neutron
    - mode: 640
########################### rsync db######################################### 
    
rsync_neutron_db:
  cmd.run:
    - name: /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

########################## service running #############################################
    

neutron-linuxbridge-agent.service:
  service.running:
    - name: neutron-linuxbridge-agent.service
    - enable: True
    - restart: True
    - watch:
      - file: /etc/neutron/plugins/ml2/linuxbridge_agent.ini
    - require:
      - pkg: openstack-neutron-linuxbridge

neutron-dhcp-agent:
  service.running:
    - name: neutron-dhcp-agent
    - enable: True
    - restart: True
    - watch:
      - file: /etc/neutron/dhcp_agent.ini
    - require:
      - pkg: openstack-neutron
      - pkg: openstack-neutron-linuxbridge

neutron-metadata-agent:
  service.running:
    - name: neutron-metadata-agent
    - enable: True
    - restart: True
    - watch:
      - file: /etc/neutron/metadata_agent.ini
    - require:
      - pkg: openstack-neutron

neutron-l3-agent:
  service.running:
    - name: neutron-l3-agent
    - enable: True
    - restart: True
    - watch:
      - file: /etc/neutron/l3_agent.ini
    - require: 
      - pkg: openstack-neutron

neutron-server:
  service.running:
    - name: neutron-server.service
    - enable: True
    - restart: True
    - watch:
      - file: /etc/neutron/neutron.conf
      - service: neutron-dhcp-agent
    - require:
      - pkg: openstack-neutron
      - service: neutron-dhcp-agent

neutron-server-restart:
  cmd.run:
    - name: systemctl restart neutron-server.service
