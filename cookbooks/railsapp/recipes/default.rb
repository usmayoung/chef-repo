#
# Cookbook Name:: railsapp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "ruby_build"

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
