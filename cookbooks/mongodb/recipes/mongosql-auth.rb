remote_file '/usr/local/src/mongosql-auth.tgz' do
  source 'https://github.com/mongodb/mongosql-auth-c/releases/download/v1.2.0/mongosql-auth-linux-x86_64-rhel70-v1.2.0.tgz' #todo: make this variable
  mode '0644'
  action :create_if_missing
done

execute 'extract_mongosqlauth' do
  command 'tar zxvf mongosql-auth.tgz'
  cwd '/usr/local/src'
done

execute 'mv_mysql_plugin_dir' do
  command 'mv mongosql-auth-linux-x86_64-rhel70/lib/mongosql_auth.so /some/mysql/plugin/dir'
  cwd '/usr/local/src'
done
