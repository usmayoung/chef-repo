#
# Cookbook Name:: railsapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#include_recipe "ruby_build"

# USED SO NOKOGIRL GEM WILL BUILD
package "libxslt-dev" 
package "libxml2-dev"


include_recipe "railsapp::rubyinstall"

include_recipe "nginx"
include_recipe "mysql::client"
include_recipe "mysql::server"
include_recipe "mysql::ruby"

#ruby_version = node["railsapp"]["ruby"]["version"]

#ruby_build_ruby(ruby_version) do
  #prefix_path "/usr/local/bin"
  #action      :install
#end

#bash "update-rubygems" do
  #code   "gem update --system"
 # not_if "gem list | grep -q rubygems-update"
#end

#gem_package "bundler"

#directory node.default['railsapp']['gem_binary'] do
  #owner 'root'
  #group 'root'
  #mode 777
  #action :create
  #recursive true
#end

#template "/home/user/.ssh/authorized_keys" do
 # source "authorized_keys"
#  mode 0400
 # owner "user"
#end

bash "update-rubygems" do
  code   "gem update --system"
  not_if "gem list | grep -q rubygems-update"
end

gem_package "bundler"

#bash "passenger" do
  #code   "gem install passenger"
  #not_if "gem list | grep -q rubygems-update"
#end

#gem_package "passenger" do
  #package_name "passenger"
  #version node.default['railsapp']['passenger_version']
  #gem_binary node.default['railsapp']['gem_binary']
  #options node.default['railsapp']['gem_options']
#end
 
#gem_package "rails" do
 # package_name "rails"
  #version node.default['railsapp']['rails_version']
  #gem_binary node.default['railsapp']['gem_binary']
  #options node.default['railsapp']['gem_options']
#end

template "/etc/nginx/sites-enabled/default" do
  source "nginx_conf.erb"
  #owner node[:user][:name]
end

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

#bash "rails bundle install" do
  #code   "cd /vagrant && bundle install"
#end

