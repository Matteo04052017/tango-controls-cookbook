#
# Cookbook Name:: tango
# Recipe:: default
#
# Copyright (c) 2016 Matteo Di Carlo, All Rights Reserved.
#
#

include_recipe 'tango::database'
include_recipe 'tango::default'

template '/etc/init/tangoservice.conf' do
  source 'tangoservice.conf.erb'
  mode 0755
  owner node['tango']['username']
  group node['tango']['group'] 
  variables(
    :tango_user        => node['tango']['username'],
    :tango_port        => node['tango']['port'],
    :mysql_user        => node['tango']['db_username'],
    :mysql_password        => node['tango']['db_password'])
end

bash "ldconfig" do
  code <<-EOS
ldconfig
EOS
end

service 'tangoservice' do
  action [:enable, :start]
end

