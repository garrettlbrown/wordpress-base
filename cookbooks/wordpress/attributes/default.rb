default['apache']['mpm'] = 'prefork'

default["mysql"]["tunable"]["connect_timeout"]    = "3600"
default["mysql"]["tunable"]["net_read_timeout"]   = "3600"
default["mysql"]["tunable"]["wait_timeout"]       = "3600"
default['mysql']['tunable']['max_allowed_packet'] = "256M"
default['mysql']['bind_address']                  = "localhost"

default['wordpress']['name']                      = "wordpress-base"
default['wordpress']['content_directory']         = "wp-content" 

default['database']['prefix']                     = 'wp_'

default['multisite']                              = false
default['multisite_domain']                       = 'mysite.com'
default['multisite_subdomain']                    = false