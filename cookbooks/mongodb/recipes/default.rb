package %w(net-snmp-libs net-snmp-utils net-snmp cyrus-sasl cyrus-sasl-gssapi cyrus-sasl-plain krb5-libs libcurl libpcap lm_sensors-libs net-snmp net-snmp-agent-libs openldap openssl rpm-libs tcp_wrappers-libs) do
  action :install
end

template '/etc/selinux/config' do
  source 'selinux.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

#todo: most of this should be moved to a tarball install specific recipe (as opposed to yum recipe, both should be usable)

user 'mongod' do
  action :create
  shell '/bin/bash'
  manage_home false
end

directory '/etc/mongodb' do
  owner 'mongod'
  group 'mongod'
  mode '0755'
  action :create
end

directory '/usr/local/src' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory '/usr/local/bin' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory '/var/log/mongodb' do
  owner 'mongod'
  group 'mongod'
  mode '0755'
  action :create
end

bash 'bootstrap' do
  code <<-EOH

#    setenforce 0
#    yum update -y #todo: more elegant cross-distro needed here

#    cd /usr/local/src/
#    if \[ ! -f /usr/local/src/mongodb.tgz \]; then
#      curl -o mongodb.tgz https://downloads.mongodb.com/linux/mongodb-linux-x86_64-enterprise-rhel70-3.6.5.tgz #todo: make this a variable
#    fi
#    tar xvf mongodb.tgz
#    rsync -a /usr/local/src/mongodb-linux-x86_64-enterprise-rhel70-3.6.5/bin/ /usr/local/bin/ #todo: continue working with variable

    EOH
end
