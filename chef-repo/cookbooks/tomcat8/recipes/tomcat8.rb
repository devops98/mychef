#
# Cookbook:: tomcat714jenkinswar
# Recipe:: tomcat714
#
# Copyright:: 2016, The Authors, All Rights Reserved.

package [ 'tree', 'apache2', 'default-jdk', 'git', 'maven', 'tomcat8', 'tomcat8-docs', 'tomcat8-admin', 'tomcat8-examples']

cookbook_file 'var/www/html/index.html' do
   source 'index.html'
   mode '755'
end

cookbook_file '/etc/tomcat8/tomcat-users.xml' do
  source 'tomcat-users.xml'
  mode '0755'
  owner 'root'
  group 'root'
  action :create
end

service 'tomcat7' do
  supports :status => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end

# %w[ /var /var/lib /var/lib/tomcat8 /var/lib/tomcat8/webapps /var/lib/tomcat8/webapps/jenkins ].each do |path|
#  directory path do
#    owner 'tomcat8'
#    group 'tomcat8'
#    mode '0775'
#    action :create
#  end
# end

remote_file '/var/lib/tomcat8/webapps/jenkins.war' do
  source 'http://mirrors.jenkins-ci.org/war/latest/jenkins.war'
  owner 'root'
  group 'root'
  mode '0775'
end

%w[ /usr /usr/share /usr/share/tomcat8 /usr/share/tomcat8/.jenkins ].each do |path|
  directory path do
    owner 'tomcat8'
    group 'tomcat8'
    mode '0775'
    action :create
  end
end

service 'tomcat7' do
    supports :status => true, :stop => true, :restart => true, :reload => true
    action [ :enable, :start ]
end
