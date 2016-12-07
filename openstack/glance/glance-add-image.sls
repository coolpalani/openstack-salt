image:
  file.managed:
    - name: /root/openstack/cirros-0.3.4-x86_64-disk.img
    - source: salt://openstack/glance/cirros-0.3.4-x86_64-disk.img
    - mode: 644
    - user: root
  cmd.run: 
    - name: source /root/openstack/admin-openrc && openstack image create "cirros" --file /root/openstack/cirros-0.3.4-x86_64-disk.img --disk-format qcow2 --container-format bare --public
