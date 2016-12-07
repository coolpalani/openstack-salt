基于salt来一键部署openstack
######################################################################
"  system                                    系统的一些配置组件
"  openstack.openstack_client                openstack客户端
"  openstack.mariadb.mariadb                 mariadb数据库
"  openstack.rabbitmq.rabbitmq               rabbitmq 安装并添加openstack用户以及赋权
"  openstack.memcache.memcache               memcache && python-memcached 安装
"  openstack.keystone.keystone               keystone 认证服务
"  openstack.keystone.keystone-admin         创建服务实体和端点api
"  openstack.glance.glance-keystone          创建glance的keystone认证
"  openstack.glance.glance-api               glance-api服务
"  openstack.glance.glance-add-image         上传官方的最小化系统包
"  openstack.nova.nova-keystone              创建nova的keystone认证
"  openstack.nova.nova-api                   控制节点的nova服务
"  openstack.neutron.neutron-keystone        创建neutron的keystone认证
"  openstack.neutron.neutron                 控制节点的neutron服务
"  openstack.dashboard.dashboard             dashboard 仪表盘
"  openstack.cinder.cinder-keystone          创建cinder的keystone认证
"  openstack.cinder.cinder                   cinder服务

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
