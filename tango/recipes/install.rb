#
# Cookbook Name:: tango
# Recipe:: instal
#
#Copyright (c) 2016 Matteo Di Carlo, All Rights Reserved.
#

include_recipe "python"

apt_package 'libtool' do
	:install
end

apt_package 'pkg-config' do
	:install
end

apt_package 'build-essential' do
	:install
end

apt_package 'autoconf' do
	:install
end

apt_package 'automake' do
	:install
end

apt_package 'default-jdk' do
	:install
end

apt_package 'mysql-workbench' do
	:install
end

apt_package 'daemon' do
	:install
end

apt_package 'libpng-dev' do
	:install
end

apt_package 'zlib1g-dev' do
	:install
end

libsodium_latest = Chef::Config[:file_cache_path] + "/#{node['tango']['libsodium_tar']}"
#if !File.exist?('/usr/local/include/sodium.h')
	remote_file libsodium_latest do
	  source node['tango']['libsodium_source_tar']
	  mode "0644"
	end

	execute "untar-libsodium" do
	  cwd Chef::Config[:file_cache_path]
	  command "tar -xzf " + libsodium_latest
	end

	libsodium_path = Chef::Config[:file_cache_path] + "/#{node['tango']['libsodium_version']}"
	bash 'install_libsodium' do
	  user 'root'
	  cwd libsodium_path
	  code <<-EOH
	  ./configure
	  make
	  make install
	  EOH
	end
#end

omniorb_latest = Chef::Config[:file_cache_path] + "/#{node['tango']['omniorb_tar']}"
#if !File.exist?('/usr/local/include/omniORB4/omniORB.h')
	remote_file omniorb_latest do
	  source node['tango']['omniorb_source_tar']
	  mode "0644"
	end

	execute "untar-omniorb" do
	  cwd Chef::Config[:file_cache_path]
	  command "tar -jxvf " + omniorb_latest
	end

	omniorb_path = Chef::Config[:file_cache_path] + "/#{node['tango']['omniorb_version']}"
	bash 'install_omniorb' do
	  user 'root'
	  cwd omniorb_path
	  code <<-EOH
	  ./configure
	  make
	  make install
	  EOH
	end
#end

zeromq_latest = Chef::Config[:file_cache_path] + "/#{node['tango']['zeromq_tar']}"
#if !File.exist?('/usr/local/include/zmq.h')
	remote_file zeromq_latest do
	  source node['tango']['zeromq_source_tar']
	  mode "0644"
	end

	execute "untar-zeromq" do
	  cwd Chef::Config[:file_cache_path]
	  command "tar -xzf " + zeromq_latest
	end

	zeromq_path = Chef::Config[:file_cache_path]  + "/#{node['tango']['zeromq_version']}"
	bash 'install_zeromq' do
	  user 'root'
	  cwd zeromq_path
	  code <<-EOH
	  ./configure
	  make
	  make install
	  EOH
	end
#end


tango_latest = Chef::Config[:file_cache_path] + "/#{node['tango']['tango_tar']}"
#if !File.exist?('/usr/local/include/tango/tango.h')
	remote_file tango_latest do
	  source node["tango"]["tango_source_tar"] #"http://heanet.dl.sourceforge.net/project/tango-cs/tango-9.1.0.tar.gz"
	  mode "0644"
	end

	execute "untar-tango" do
	  cwd Chef::Config[:file_cache_path]
	  command "tar -xzf " + tango_latest
	end

	tango_path = Chef::Config[:file_cache_path] + "/#{node['tango']['tango_version']}"
	bash 'install_tango' do
	  user 'root'
	  cwd tango_path
	  code <<-EOH
	  ./configure --with-mysql-ho=127.0.0.1 --with-mysql-admin=root --with-mysql-admin-passwd=#{node['mysql']['server_root_password']}  > output_configure.txt
	  make all > output_makeall.txt
	  make install > output_makeinstall.txt
	  EOH
	end
#end

