glance:
  mysql_server: {{ grains['ip_interfaces']['eth0'][0] }}
  controller_hostname: {{ salt['grains.get']('id', '') }}
  glance_database: glance
  glance_user: glance
  glance_passwd: glance
  glance_keystone_passwd: glance
  ADMIN_TOKEN: 27f596c8aeb65562cd58
