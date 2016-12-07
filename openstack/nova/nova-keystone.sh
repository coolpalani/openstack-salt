unset OS_TOKEN OS_URL 
source /root/openstack/admin-openrc 
openstack user create --domain default --password nova {{nova_keystone_passwd}}
openstack role add --project service --user nova admin 
openstack service create --name nova --description "OpenStack Compute" compute 
openstack endpoint create --region RegionOne compute public http://controller:8774/v2.1/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute internal http://controller:8774/v2.1/%\(tenant_id\)s 
openstack endpoint create --region RegionOne compute admin http://controller:8774/v2.1/%\(tenant_id\)s
