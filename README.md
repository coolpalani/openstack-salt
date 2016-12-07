salt/
├── files
│   ├── minion
│   │   ├── epel-release-7-8.noarch.rpm
│   │   ├── epel.repo
│   │   └── minion
│   ├── openstack
│   │   └── yovole_yum_openstack.repo
│   └── system
│       ├── motd.sh
│       └── vimrc
├── _grains
│   └── check_vmx_libvirt.py
├── minion.sls
├── openstack
│   ├── cinder
│   │   ├── cinder.conf
│   │   ├── cinder-keystone.sh
│   │   ├── cinder-keystone.sls
│   │   └── cinder.sls
│   ├── dashboard
│   │   ├── dashboard.sls
│   │   └── local_settings
│   ├── glance
│   │   ├── cirros-0.3.4-x86_64-disk.img
│   │   ├── glance-add-image.sls
│   │   ├── glance-api.conf
│   │   ├── glance-api.sls
│   │   ├── glance-keystone.sh
│   │   ├── glance-keystone.sls
│   │   └── glance-registry.conf
│   ├── install_openstack.sh
│   ├── keystone
│   │   ├── admin-openrc
│   │   ├── demo-openrc
│   │   ├── httpd.conf
│   │   ├── keystone-admin.sh
│   │   ├── keystone-admin.sls
│   │   ├── keystone.conf
│   │   ├── keystone.sls
│   │   └── wsgi-keystone.conf
│   ├── mariadb
│   │   ├── mariadb.sls
│   │   └── openstack.cnf
│   ├── memcache
│   │   └── memcache.sls
│   ├── neutron
│   │   ├── dhcp_agent.ini
│   │   ├── l3_agent.ini
│   │   ├── linuxbridge_agent_compute.ini
│   │   ├── linuxbridge_agent.ini
│   │   ├── metadata_agent.ini
│   │   ├── ml2_conf.ini
│   │   ├── neutron_compute.conf
│   │   ├── neutron_compute.sls
│   │   ├── neutron.conf
│   │   ├── neutron-keystone.sh
│   │   ├── neutron-keystone.sls
│   │   └── neutron.sls
│   ├── nova
│   │   ├── nova-api.sls
│   │   ├── nova-compute.conf
│   │   ├── nova-compute.sls
│   │   ├── nova.conf
│   │   ├── nova-keystone.sh
│   │   └── nova-keystone.sls
│   ├── openstack_client.sls
│   └── rabbitmq
│       └── rabbitmq.sls
├── pillar
│   ├── openstack
│   │   ├── cinder.sls
│   │   ├── controller.sls
│   │   ├── glance.sls
│   │   ├── keystone.sls
│   │   ├── neutron.sls
│   │   ├── nova.sls
│   │   └── rabbitmq.sls
│   └── top.sls
├── salt-event.py
├── system.sls
└── top.sls
