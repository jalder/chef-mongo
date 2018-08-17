yum_repository 'mongodb-enterprise' do
  description 'MongoDB Enterprise Repository'
  baseurl 'https://repo.mongodb.com/yum/redhat/$releasever/mongodb-enterprise/4.0/$basearch/'
  gpgkey 'https://www.mongodb.org/static/pgp/server-4.0.asc'
  enabled true
  gpgcheck true
  action :create
end

package 'mongodb-enterprise' do
  action :install
end

