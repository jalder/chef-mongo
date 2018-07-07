package %w(net-snmp-libs net-snmp-utils net-snmp cyrus-sasl cyrus-sasl-gssapi cyrus-sasl-plain krb5-libs libcurl libpcap lm_sensors-libs net-snmp net-snmp-agent-libs openldap openssl rpm-libs tcp_wrappers-libs) do
  action :install
end

#just packages that pertain to mongodb-bic work
package %w(mariadb) do
  action :install
end

template '/etc/selinux/config' do
  source 'selinux.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

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

template '/etc/mongodb/mongod0.conf' do
  source 'mongod0.conf'
  owner 'mongod'
  group 'mongod'
  mode '0644'
end

template '/etc/mongodb/mongosqld.conf' do
  source 'mongosqld.conf'
  owner 'mongod'
  group 'mongod'
  mode '0644'
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

directory '/data/db' do
  owner 'mongod'
  group 'mongod'
  mode '0755'
  recursive true
  action :create
end

bash 'bootstrap' do
  code <<-EOH

    setenforce 0
    yum update -y #todo: more elegant cross-distro needed here

    cd /usr/local/src/
    if \[ ! -f /usr/local/src/mongodb.tgz \]; then
      curl -o mongodb.tgz https://downloads.mongodb.com/linux/mongodb-linux-x86_64-enterprise-rhel70-3.6.5.tgz #todo: make this a variable
    fi
    tar xvf mongodb.tgz
    rsync -a /usr/local/src/mongodb-linux-x86_64-enterprise-rhel70-3.6.5/bin/ /usr/local/bin/ #todo: continue working with variable

    #todo: this doesnt catch unclean shutdowns of mongod
    if \[ ! -f /data/db/mongod.lock \]; then
      sudo -H -u mongod /usr/local/bin/mongod -f /etc/mongodb/mongod0.conf
    fi

    #todo: make this a variable
    tar -xvzf mongodb-bi-linux-x86_64-rhel70-v2.6.0-beta1.tgz
    install -m755 mongodb-bi-linux-x86_64-rhel70-v2.6.0-beta1/bin/mongo* /usr/local/bin/

    #todo: insert sample json into mongod

    #todo: use inserted samples in the conf for setting sampleNamespaces or directory, kick off the rdrl? service to sample on periodic basis

    #todo: start the service
    sudo -H -u mongod /usr/local/bin/mongosqld --config=/etc/mongodb/mongosqld.conf &

    #todo: get adminer.php, LAMP stack, and config it to start exploring data

    EOH
end
