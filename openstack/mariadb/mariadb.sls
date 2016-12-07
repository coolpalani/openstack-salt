mariadb-server:
  pkg.installed:
    - name: mariadb-server
  file.managed:
    - name: /etc/my.cnf.d/openstack.cnf
    - source: salt://openstack/mariadb/openstack.cnf
    - template: jinja
    - require:
      - pkg: mariadb-server
    - defaults:
      mysql_server: {{ pillar['keystone']['mysql_server'] }}
  service.running:
    - name: mariadb
    - enable: True
    - restart: True
    - require:
      - file: /etc/my.cnf.d/openstack.cnf
    - watch:
      - file: /etc/my.cnf.d/openstack.cnf

python2-PyMySQL:
  pkg.installed:
    - name: python2-PyMySQL
