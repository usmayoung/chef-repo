#
# Cookbook Name:: ffmpeg2
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


## add some mandatory build tools
%w{git-core subversion build-essential nasm pkg-config}.each do |pkg|
  package pkg do
    action :install
  end
end

## Installing AAC, MP3, Theora, Vorbis, AMR, GSM
%w{libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev libopencore-amrnb-dev libopencore-amrwb-dev libgsm1-dev zlib1g-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

include_recipe 'yasm::source'

##Installing libx264
creates_x264 = "/usr/local/bin/x264"
file "/usr/local/bin/x264" do
    action :nothing
end

git "#{Chef::Config['file_cache_path']}/x264" do
    repository 'git://git.videolan.org/x264.git'
    reference "stable"
    action :sync
    notifies :delete, "file[#{creates_x264}]", :immediately
end

bash "compile_x264" do
    cwd "#{Chef::Config['file_cache_path']}/x264"
    code <<-EOH
        ./configure --prefix=/usr/local --enable-shared
        make && make install
    EOH
    creates "#{creates_x264}"
end


#Installing libxvid
bash "install libxvid" do
  user "root"
  cwd "#{Chef::Config['file_cache_path']}"
  code <<-EOH
  wget http://downloads.xvid.org/downloads/xvidcore-1.3.2.tar.gz
  tar xvfz xvidcore-1.3.2.tar.gz
  cd xvidcore/build/generic
  ./configure --prefix=/usr/local
  make
  make install
  EOH
  not_if { ::File.exists?("/usr/local/lib/libxvidcore.a") }
end

#Configuring ffmpeg and installing
creates_ffmpeg = "/usr/local/bin/ffmpeg"
file "/usr/local/bin/ffmpeg" do
    action :nothing
end

git "#{Chef::Config['file_cache_path']}/ffmpeg" do
    repository 'git://source.ffmpeg.org/ffmpeg.git'
    #reference "stable"
    action :sync
    notifies :delete, "file[#{creates_ffmpeg}]", :immediately
end

bash "compile_ffmpeg" do
    cwd "#{Chef::Config[:file_cache_path]}/ffmpeg"
    code <<-EOH
        ./configure --prefix=/usr/local --enable-gpl --enable-version3 --enable-nonfree --enable-shared --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libfaac --enable-libgsm --enable-libmp3lame --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libxvid
        make clean && make && make install && ldconfig -v
    EOH
    creates "#{creates_ffmpeg}"
end

