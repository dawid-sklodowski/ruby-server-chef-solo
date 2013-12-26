require 'pathname'

package 'vim'
package 'htop'
package 'git'
package 'git-core'
package 'mongodb'
#package 'ruby-dev'

service 'mongodb' do
  action :restart
end

group 'deploy' do
  action :create
end

user 'deploy' do
  supports :manage_home => true
  comment "Deploy User"
  group "deploy"
  home "/home/deploy"
  shell "/bin/bash"
  password `mkpasswd -m sha-512 "#{(1..150).to_a.map{ arr = (('a'..'z').to_a + ('A'..'Z').to_a); arr[rand(arr.length)] }.join}"`.strip
  action :create
end

directory "/home/deploy/.ssh" do
  owner "deploy"
  group "deploy"
  mode 0755
  action :create
end

file "/home/deploy/.ssh/authorized_keys2" do
  owner "deploy"
  group "deploy"
  mode 0644
  content File.read('/root/.ssh/authorized_keys2')
  action :create
end

gem_package 'bundler'
gem_package 'god'

file '/etc/init.d/god' do
  owner "root"
  group "root"
  mode 0755
  content (Pathname.new(File.expand_path(__FILE__)) + '..' + '..' + 'templates' + 'god').read
end

service 'god' do
  init_command '/etc/init.d/god'
  supports :start => true, :restart => true, :stop => true
  action [:enable, :start]
  start_command '/etc/init.d/god start'
  restart_command '/etc/init.d/god restart'
  stop_command '/etc/init.d/god stop'
end
