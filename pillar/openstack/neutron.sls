neutron:
  mysql_server: {{ grains['ip_interfaces']['eth0'][0] }}
  controller_hostname: {{ salt['grains.get']('id', '') }}
  neutron_database: neutron
  neutron_db_user: neutron
  neutron_db_passwd: neutron
  neutron_keystone_passwd: neutron
  metadata_passwd: metadata
  ADMIN_TOKEN: 27f596c8aeb65562cd58
