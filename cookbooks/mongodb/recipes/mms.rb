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

    yum install -y --quiet /usr/local/src/mongodb-mms-*.rpm #todo: detect if already installed and skip

    EOH
end

#todo: action :enable is breaking with error Failed to execute operation: Too many levels of symbolic links - fix this
service 'mongodb-mms' do
  action [ :start ]
end
