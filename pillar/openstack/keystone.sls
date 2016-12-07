keystone:
  mysql_server: {{ grains['ip_interfaces']['eth0'][0] }}
  controller_hostname: {{ salt['grains.get']('id', '') }}
  keystone_database: keystone
  keystone_user: keystone
  keystone_passwd: keystone
  admin_passwd: admin
  demo_passwd: demo
  ADMIN_TOKEN: 27f596c8aeb65562cd58
