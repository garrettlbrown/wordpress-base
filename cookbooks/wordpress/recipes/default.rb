include_recipe 'apt'
include_recipe 'git'
include_recipe 'vim'
include_recipe 'ark'
include_recipe 'php'
include_recipe 'apache2'
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_php5"

project = 'wordpress'
docroot = "/var/www/#{project}"
webroot = "#{docroot}/public"

package 'php5-mysql' do
  action :install
end

node.override["mysql"]["server_root_password"] = node.database.pass

include_recipe "mysql::server"
include_recipe "mysql::client"

execute "mysql -u root -p#{node.database.pass} -e \"create database if not exists #{node.database.name};\""

execute "mysql -u root -p#{node.database.pass} #{node.database.name} < database.sql" do
  not_if "mysql -u root -p#{node.database.pass} #{node.database.name} -e 'show tables' | grep 'wp'"
  cwd docroot
end

web_app project do
  docroot webroot 
end

ark 'public' do
  url 'https://wordpress.org/latest.tar.gz' 
  action :put
  path docroot
  not_if do File.directory?(webroot) end
end

Dir.foreach(node.wordpress.themes_directory) do |item|
  next if item == '.' or item == '..'

  link webroot + '/wp-content/themes/' + item do
    to node.wordpress.themes_directory + '/' + item 
  end
end

template "#{webroot}/wp-config.php" do
  source "wp-config.php.erb"
  variables(
    :database => node.database, 
  )
end
