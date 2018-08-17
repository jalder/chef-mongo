package %w(openldap openldap-servers openldap-clients compat-openldap openldap-servers-sql openldap-devel) do
  action :install
end

service 'slapd' do
  action [ :enable, :start ]
end

#notes: https://www.itzgeek.com/how-tos/linux/centos-how-tos/step-step-openldap-server-configuration-centos-7-rhel-7.html
