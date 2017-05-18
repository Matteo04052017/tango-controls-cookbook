#
# Cookbook Name:: tango
# Recipe:: database
#
# Copyright (c) 2016 Matteo Di Carlo, All Rights Reserved.

mysql2_chef_gem 'default' do
  action :install
end

# Configure the MySQL client.
mysql_client 'default' do
  action :create
end


# Configure the MySQL service.
mysql_service 'default' do
  initial_root_password node['mysql']['server_root_password']
  socket '/var/run/mysqld/mysqld.sock'
  action [:create, :start]
end

mysql_connection_info = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database node['tango']['database'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['tango']['db_username'] do
  connection mysql_connection_info
  password node['tango']['db_password']
  database_name node['tango']['database']
  privileges [:select,:update,:insert,:create,:delete]
  action :grant
end

directory '/tmp/db' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/tmp/db/create_db.sql' do
  source 'create_db.sql'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/tmp/db/create_db_tables.sql' do
  source 'create_db_tables.sql'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/tmp/db/rem_history.sql' do
  source 'rem_history.sql'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/tmp/db/stored_proc.sql' do
  source 'stored_proc.sql'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/tmp/db/update_db.sql' do
  source 'update_db.sql'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/tmp/db/update_db7.sql' do
  source 'update_db7.sql'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'initialize_tango_database' do
  cwd '/tmp/db'
  command "/usr/bin/mysql -S /var/run/mysql-default/mysqld.sock -uroot -p#{node['mysql']['server_root_password']} -h127.0.0.1 tango < ./create_db.sql"
  not_if  "/usr/bin/mysql -S /var/run/mysql-default/mysqld.sock -uroot -p#{node['mysql']['server_root_password']} -h127.0.0.1 tango -e 'describe device;'"
end


