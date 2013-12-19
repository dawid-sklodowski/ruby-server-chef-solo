package 'vim'
package 'htop'
package 'git'
package 'git-core'
package 'mongodb'

service 'mongodb' do
  action :restart
end
