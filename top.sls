######################################################################
###  system                                    系统的一些配置组件
###  openstack.openstack_client                openstack客户端
###  openstack.mariadb.mariadb                 mariadb数据库
###  openstack.rabbitmq.rabbitmq               rabbitmq 安装并添加openstack用户以及赋权
  #  openstack.memcache.memcache               memcache && python-memcached 安装
##  openstack.keystone.keystone               keystone 认证服务
base: 
    'controller':
        - system
        - openstack.openstack_client
        - openstack.mariadb.mariadb
        - openstack.rabbitmq.rabbitmq
        - openstack.memcache.memcache
        - openstack.keystone.keystone
        - openstack.keystone.keystone-admin
        - openstack.glance.glance-keystone
        - openstack.glance.glance-api
        - openstack.glance.glance-add-image
        - openstack.nova.nova-keystone
        - openstack.nova.nova-api
        - openstack.neutron.neutron-keystone
        - openstack.neutron.neutron
        - openstack.dashboard.dashboard
        - openstack.cinder.cinder-keystone
        - openstack.cinder.cinder

    'compute':
        - system
        - openstack.openstack_client
        - openstack.nova.nova-compute
        - openstack.neutron.neutron_compute
