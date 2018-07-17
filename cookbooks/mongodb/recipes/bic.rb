package %w(mariadb) do
  action :install
end

template '/etc/mongodb/mongosqld.conf' do
  source 'mongosqld.conf'
  owner 'mongod'
  group 'mongod'
  mode '0644'
end

bash 'bootstrap' do
  code <<-EOH

    cd /usr/local/src
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
