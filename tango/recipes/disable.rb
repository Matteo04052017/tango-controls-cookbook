#
# Cookbook Name:: tango
# Recipe:: disable
#
# Copyright 2016, INAF OATe
#
# All rights reserved - Do Not Redistribute
#

service 'tangoservice' do
  action [:disable, :stop]
end

