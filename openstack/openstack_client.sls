python-openstackclient:
  pkg.installed:
    - name: python-openstackclient

  cmd.run:
    - name: mkdir /root/openstack/
    - unless: test -d /root/openstack/
