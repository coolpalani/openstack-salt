cinder:
  mysql_server: {{ grains['ip_interfaces']['eth0'][0] }}
  controller_hostname: {{ salt['grains.get']('id', '') }}
  cinder_database: cinder
  cinder_db_user: cinder
  cinder_db_passwd: cinder
  cinder_keystone_passwd: cinder
  ADMIN_TOKEN: 27f596c8aeb65562cd58
