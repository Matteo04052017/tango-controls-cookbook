#
# Cookbook Name:: tango
# Recipe:: default
#
# Copyright (c) 2016 Matteo Di Carlo, All Rights Reserved.
#

installed = false
if File.exist?('/usr/local/include/sodium.h')
	installed = true
end
if File.exist?('/usr/local/include/omniORB4/omniORB.h')
	installed = true
end
if File.exist?('/usr/local/include/zmq.h')
	installed = true
end
if File.exist?('/usr/local/include/tango/tango.h')
	installed = true
end

if "#{node['tango']['install']}" == "true" || !installed
  include_recipe 'tango::install'
end

template '/etc/environment' do
  source 'environment.erb'
  mode 0755
  owner node['tango']['username']
  group node['tango']['group'] 
  variables(
    :tango_host        => node['tango']['host'],
    :tango_port        => node['tango']['port'],
    :mysql_user        => node['tango']['db_username'],
    :mysql_password        => node['tango']['db_password'])
end

