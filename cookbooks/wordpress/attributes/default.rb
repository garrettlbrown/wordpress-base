default['apache']['mpm'] = 'prefork'

default["mysql"]["tunable"]["connect_timeout"]    = "3600"
default["mysql"]["tunable"]["net_read_timeout"]   = "3600"
default["mysql"]["tunable"]["wait_timeout"]       = "3600"
default['mysql']['tunable']['max_allowed_packet'] = "256M"
default['mysql']['bind_address']                  = "localhost"
