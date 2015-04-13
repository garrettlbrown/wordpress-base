include_recipe 'apt'
include_recipe 'git'
include_recipe 'vim'
include_recipe 'ark'
include_recipe 'php'
include_recipe 'apache2'
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_php5"

docroot = "/var/www/" + node.wordpress.name
webroot = "#{docroot}/public"

package 'php5-mysql' do
  action :install
end

node.override["mysql"]["server_root_password"] = node.database.pass

include_recipe "mysql::server"
include_recipe "mysql::client"

execute "mysql -u root -p#{node.database.pass} -e \"create database if not exists #{node.database.name};\""

execute "mysql -u root -p#{node.database.pass} #{node.database.name} < database.sql" do
 not_if { !File.exist?("database.sql") || "mysql -u root -p#{node.database.pass} #{node.database.name} -e 'show tables' | grep '#{node['database']['prefix']}'" }
 cwd docroot
end

web_app node.wordpress.name do
  docroot webroot 
end

ark 'public' do
  url 'https://wordpress.org/latest.tar.gz' 
  action :put
  path docroot
  not_if do File.directory?(webroot) end
end

directory webroot + '/wp-content' do
  recursive true
  action :delete
end

link webroot + '/wp-content' do
  to node.wordpress.content_directory 
end

template "#{webroot}/wp-config.php" do
  source "wp-config.php.erb"
  variables(
    :database => node.database, 
  )
end
