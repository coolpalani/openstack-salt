unset OS_TOKEN OS_URL 
source /root/openstack/admin-openrc
openstack user create --domain default --password glance {{glance_keystone_passwd}}
openstack role add --project service --user glance admin 
openstack service create --name glance --description "OpenStack Image" image 
openstack endpoint create --region RegionOne image public http://{{controller_hostname}}:9292 
openstack endpoint create --region RegionOne image internal http://{{controller_hostname}}:9292 
openstack endpoint create --region RegionOne image admin http://{{controller_hostname}}:9292
