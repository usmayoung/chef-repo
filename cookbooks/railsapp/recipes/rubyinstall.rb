#execute 'apt-get install -y python-software-properties python g++ make' do
  #user "root"
#end

#execute 'add-apt-repository ppa:chris-lea/node.js' do
  #user "root"
#end

#execute 'apt-get update' do
  #user "root"
#end

#apt_package "nodejs"
apt_package "curl"
apt_package "git-core"
apt_package "build-essential"
apt_package "libcurl4-openssl-dev"
apt_package "zlib1g-dev"
 
execute "curl -L get.rvm.io | bash -s stable --ruby=#{node.default['railsapp']['combined']}" do
  not_if do
    ::File.directory?("/usr/local/rvm")
  end
  user "root"
end

execute "source" do
  command "echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc; echo 'export rvmsudo_secure_path=0' >> /etc/bash.bashrc; source /usr/local/rvm/scripts/rvm; rvm use #{node.default['railsapp']['combined']} --default; /bin/bash --login; touch /etc/chefflag-source"
  not_if do
    ::File.exists?('/etc/chefflag-source')
  end
  user "root"
end
 
execute "ruby -v" do
  command "bash -c 'source /usr/local/rvm/scripts/rvm; ruby -v'"
  user "root"
end

