#
# Cookbook Name:: yasm
# Recipe:: source
#
# Copyright 2012-2013, Escape Studios
#

include_recipe "build-essential"
include_recipe "git"

#yasm_packages.each do |pkg|
    #package pkg do
       # action :purge
    #end
#end

creates_yasm = "/usr/local/bin/yasm"

file "#{creates_yasm}" do
    action :nothing
end

git "#{Chef::Config[:file_cache_path]}/yasm" do
    repository 'git://github.com/yasm/yasm.git'
    reference "HEAD"
    action :sync
    notifies :delete, resources(:file => creates_yasm), :immediately
end

#write the flags used to compile to disk
template "#{Chef::Config[:file_cache_path]}/yasm-compiled_with_flags" do
    source "compiled_with_flags.erb"
    owner "root"
    group "root"
    mode 0600
    variables(
        :compile_flags => []
    )
    notifies :delete, resources(:file => creates_yasm), :immediately
end

bash "compile_yasm" do
    cwd "#{Chef::Config[:file_cache_path]}/yasm"
    code <<-EOH
        autoreconf
        automake --add-missing
        ./configure --prefix=/usr/local
        make clean && make && make install
    EOH
    creates "#{creates_yasm}"
end