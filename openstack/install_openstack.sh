salt-ssh '*' cmd.run 'rm -rfv /etc/yum.repos.d/*'
salt-ssh '*' cmd.run 'yum clean all'
salt-ssh '*' cmd.run 'yum makecache'
salt-ssh '*' state.sls minion
