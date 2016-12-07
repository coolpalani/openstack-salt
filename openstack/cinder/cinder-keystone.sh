#!/bin/bash
unset OS_TOKEN OS_URL 
source /root/openstack/admin-openrc 
openstack user create --domain default --password cinder {{cinder_keystone_passwd}} 
openstack role add --project service --user cinder admin 
openstack service create --name cinder --description "OpenStack Block Storage" volume 
openstack service create --name cinderv2 --description "OpenStack Block Storage" volumev2 
openstack endpoint create --region RegionOne volume public http://controller:8776/v1/%\(tenant_id\)s 
openstack endpoint create --region RegionOne volume internal http://controller:8776/v1/%\(tenant_id\)s 
openstack endpoint create --region RegionOne volume admin http://controller:8776/v1/%\(tenant_id\)s
openstack endpoint create --region RegionOne volumev2 public http://controller:8776/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne volumev2 internal http://controller:8776/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne volumev2 admin http://controller:8776/v2/%\(tenant_id\)s 
