remote_file '/usr/local/src/mongodb-mms.rpm' do
  source 'https://downloads.mongodb.com/on-prem-mms/rpm/mongodb-mms-4.0.1.50101.20180801T1117Z-1.x86_64.rpm' #todo: make this a variable
  owner 'root'
  group 'root'
  mode '0644'
  action :create_if_missing
end

yum_package 'mongodb-mms' do
  action :install
  source '/usr/local/src/mongodb-mms.rpm'
end

#todo: move automation agent to own recipe
#yum_package 'mongodb-mms-automation-agent-manager' do
#  action :upgrade
#  allow_downgrade true
#  source '/usr/local/src/mongodb-mms-automation-agent-manager-4.5.15.5279-1.x86_64.rhel7.rpm' #todo: make this a variable
#end

bash 'bootstrap' do
  code <<-EOH

    #todo: set /opt/mongodb/mms/conf/conf-mms.properties values (mongod URI connection string)
   
    #todo: pass eval commands to mongod to initiate the replica set for the mms backing
    #todo: fetch the mongodb-mms rpm via wget, currently it requires developer to place the rpm in the ./src/ vagrant-synced folder
    #todo: initial ops manager root owner account
    #todo: initial ops manager configuration
    #todo: initial ops manager PEM for HTTPS
    #todo: initial ops manager SMTP settings
    #todo: initial target test replica set
    #todo: automation agent install recipes

    EOH
end

#todo: need to configure appdb backing database first before starting
#todo: action :enable is breaking with error Failed to execute operation: Too many levels of symbolic links - fix this
service 'mongodb-mms' do
  action [ :start ]
end
