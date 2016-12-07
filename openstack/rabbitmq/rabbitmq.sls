rabbitmq-server:
  pkg.installed:
    - name: rabbitmq-server
  service.running:
    - name: rabbitmq-server
    - enable: True
    - require: 
      - pkg: rabbitmq-server
  cmd.run:
    - template: jinja
    - name: rabbitmqctl add_user {{ pillar['rabbitmq']['rabbitmq_user'] }} {{ pillar['rabbitmq']['rabbitmq_passwd'] }}  && rabbitmqctl set_permissions {{ pillar['rabbitmq']['rabbitmq_user'] }} ".*" ".*" ".*"
    - require: 
      - pkg: rabbitmq-server
