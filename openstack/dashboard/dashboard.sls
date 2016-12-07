openstack-dashboard:
  pkg.installed:
    - name: openstack-dashboard

httpd:
  service.running:
    - name: httpd
    - restart: True
    - watch:
      - file: /etc/openstack-dashboard/local_settings

memcached:
  service.running:
    - name: memcached
    - restart: True
    - watch:
      - file: /etc/openstack-dashboard/local_settings


/etc/openstack-dashboard/local_settings:
  file.managed:
    - source: salt://openstack/dashboard/local_settings
    - user: root
    - group: apache
    - mode: 640
    - require:
      - pkg: openstack-dashboard
    - template: jinja
    - defaults:
      controller_server: {{ pillar['controller']['controller'] }}
