#
# Cookbook Name:: railsapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "ruby_build"
include_recipe "mysql::client"
include_recipe "mysql::server"
include_recipe "mysql::ruby"

ruby_version = node["railsapp"]["ruby"]["version"]

ruby_build_ruby(ruby_version) do
  prefix_path "/usr/local/ruby/"+ruby_version
  action      :install
end

bash "update-rubygems" do
  code   "gem update --system"
  not_if "gem list | grep -q rubygems-update"
end

gem_package "bundler"

mysql_database node['railsapp']['database'] do
  connection ({:host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end

mysql_database_user node['railsapp']['db_username'] do
  connection ({:host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password']})
  password node['railsapp']['db_password']
  database_name node['railsapp']['database']
  privileges [:select,:update,:insert,:create,:delete]
  action :grant
end
