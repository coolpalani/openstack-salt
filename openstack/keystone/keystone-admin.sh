unset OS_TOKEN OS_URL
export OS_TOKEN=27f596c8aeb65562cd58 
export OS_URL=http://{{controller_hostname}}:35357/v3
export OS_IDENTITY_API_VERSION=3 
openstack service create --name keystone --description "OpenStack Identity" identity
openstack endpoint create --region RegionOne identity public http://{{controller_hostname}}:5000/v3 
openstack endpoint create --region RegionOne identity internal http://{{controller_hostname}}:5000/v3 
openstack endpoint create --region RegionOne identity admin http://{{controller_hostname}}:35357/v3 
openstack domain create --description "Default Domain" default 
openstack project create --domain default --description "Admin Project" admin 
openstack user create --domain default --password admin {{admin_passwd}}
openstack role create admin 
openstack role add --project admin --user admin admin 
openstack project create --domain default --description "Service Project" service 
openstack project create --domain default --description "Demo Project" demo 
openstack user create --domain default --password demo {{demo_passwd}} 
openstack role create user 
openstack role add --project demo --user demo user
