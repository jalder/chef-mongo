
template '/etc/mongodb/mongod0.conf' do
  source 'mongod0.conf'
  owner 'mongod'
  group 'mongod'
  mode '0644'
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

    #todo: this doesnt catch unclean shutdowns of mongod
    if \[ ! -f /data/db/mongod.lock \]; then
      sudo -H -u mongod /usr/local/bin/mongod -f /etc/mongodb/mongod0.conf
    fi

    EOH
end
