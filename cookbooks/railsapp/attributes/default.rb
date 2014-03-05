#default["railsapp"]["ruby"]["version"] = "1.9.3-p194"
default["railsapp"]["database"] = "railsapp"
default["railsapp"]["db_username"] = "railsapp"

#--------IMPORTANT! CHANGE OR OVERRIDE-----------
#default[:railsapp][:user_password] = "$1$.MZ8xPWB$/e/nAWc4C2zidbSVN9M/2/" #password
#default[:railsapp][:postgres_password] = "$1$.MZ8xPWB$/e/nAWc4C2zidbSVN9M/2/" #password
#default[:railsapp][:db_role_postgres_password] = "postgres_role_password"
#default[:railsapp][:db_role_deploy_password] = "role_password"
#default[:railsapp][:app1_secret_token] = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
# Vagrant public key-please, please, please, change this or set to empty string.
#default[:railsapp][:authorized_keys] = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
#-----------------
 
# Versions
default['railsapp']['ruby_version'] = '1.9.3'
default['railsapp']['package_version'] = 'p374'
default['railsapp']['rails_version'] = '3.2.15'
default['railsapp']['passenger_version'] = '4.0.25'
 
default['railsapp']['combined'] = "#{default['railsapp']['ruby_version']}-#{default['railsapp']['package_version']}"
default['railsapp']['gem_binary'] = "/usr/local/rvm/bin/gem-ruby-#{node.default['railsapp']['combined']}"
 
##default['bluebook']['source'] = "source /usr/local/rvm/scripts/rvm"
default['railsapp']['source'] = "source /etc/profile.d/rvm.sh"
default['railsapp']['gem_options'] = "--no-ri --no-rdoc"
 
default['railsapp']['app1'] = "your_rails_app"
default['railsapp']['webroot'] = "/var/www/"
# The current directory is used by Mina to link to the current version of the web app.
default['railsapp']['total_url_app1'] = "#{default['railsapp']['webroot']}#{default['railsapp']['app1']}/current"
 
default[:railsapp][:db_role_deploy_username] = "deploy"
default[:railsapp][:db_role_deploy_database] = "your_rails_db"

