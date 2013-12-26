package 'vim'
package 'htop'
package 'git'
package 'git-core'
package 'mongodb'

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
