memcached-memcache:
  pkg.installed:
    - name: memcached
  service.running:
    - name: memcached
    - enable: True
    - require: 
      - pkg: memcached
python-memcached:
  pkg.installed:
    - name: python-memcached
    - require:
      - pkg: memcached
