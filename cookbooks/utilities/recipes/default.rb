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
  gid "deploy"
  home "/home/deploy"
  shell "/bin/bash"
  action :create
end
