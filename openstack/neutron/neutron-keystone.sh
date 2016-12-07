#!/bin/bash
unset OS_TOKEN OS_URL 
source /root/openstack/admin-openrc
openstack user create --domain default --password neutron {{neutron_keystone_passwd}}
openstack role add --project service --user neutron admin 
openstack service create --name neutron --description "OpenStack Networking" network 
openstack endpoint create --region RegionOne network public http://controller:9696 
openstack endpoint create --region RegionOne network internal http://controller:9696 
openstack endpoint create --region RegionOne network admin http://controller:9696 
