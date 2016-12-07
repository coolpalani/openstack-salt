nova:
  mysql_server: {{ grains['ip_interfaces']['eth0'][0] }}
  controller_hostname: {{ salt['grains.get']('id', '') }}
  nova_database: nova
  nova_db_user: nova
  nova_db_passwd: nova
  nova_api_database: nova_api
  nova_api_db_user: nova
  nova_api_db_passwd: nova
  nova_keystone_passwd: nova
  ADMIN_TOKEN: 27f596c8aeb65562cd58

  {% if grains['check_kvm_status'] == '0' %}
  virt_type: qemu
  {% else %}
  virt_type: KVM
  {% endif %}
