#execute "testing" do
#  command %Q{
#    echo "i ran at #{Time.now}" >> /root/cheftime
#  }
#end

# uncomment to use the collectd recipe. See cookbooks/collectd/readme.md for documentation.
# include_recipe "collectd"

# uncomment to use the block recipe. See cookbooks/block/readme.md for documentation.
# include_recipe "ban"

# uncomment to use the sidekiq recipe. See cookbooks/sidekiq/readme.md for documentation.
# include_recipe "sidekiq"

#uncomment to turn on memcached
# include_recipe "memcached"

#uncomment to run the eybackup_slave recipe
# include_recipe "eybackup_slave"

#uncomment to run the ssmtp recipe
#include_recipe "ssmtp"

#uncomment to run the sunspot recipe
# include_recipe "sunspot"

#uncomment to run the exim recipe
#exim_auth "auth" do
#  my_hostname "my_hostname.com"
#  smtp_host "smtp.sendgrid.net"
#  username "username"
#  password "password"
#end

#uncomment to install specified packages
# You must add your packages to packages/attributes/packages.rb
#require_recipe "packages"

#uncomment to add specified cron jobs for application user (deploy)
# You must add your cron jobs to cron/attributes/cron.rb
#require_recipe "cron"

#uncomment to run redis.yml recipe
# include_recipe "redis-yml"

#uncomment to run the redis recipe
#include_recipe "redis"

#uncomment to run the api-keys-yml recipe
# include_recipe "api-keys-yml"

#include_recipe "logrotate"
#
#uncomment to use the solr recipe
#include_recipe "solr"

#uncomment to set environment variables in passenger or unicorn
# Set environment variables as specified in cookbooks/env_vars/attributes/env_vars.rb
#include_recipe "env_vars"

# To install a Jenkins environment, uncomment below
# include_recipe "jenkins"

#enable Extension modules for a given Postgresql database
# if ['solo','db_master', 'db_slave'].include?(node[:instance_role])
  # Extensions that support Postgres >= 9.0
  # postgresql9_autoexplain "dbname"
  # postgresql9_btree_gin "dbname"
  # postgresql9_btree_gist "dbname"
  # postgresql9_chkpass "dbname"
  # postgresql9_citext "dbname"
  # postgresql9_cube "dbname"
  # postgresql9_dblink "dbname"
  # postgresql9_dict_int "dbname"
  # postgresql9_dict_xsyn "dbname"
  # postgresql9_earthdistance "dbname"
  # postgresql9_fuzzystrmatch "dbname"
  # postgresql9_hstore "dbname"
  # postgresql9_intarray "dbname"
  # postgresql9_isn "dbname"
  # postgresql9_lo "dbname"
  # postgresql9_ltree "dbname"
  # postgresql9_pg_trgm "dbname"
  # postgresql9_pgcrypto "dbname"
  # postgresql9_pgrowlocks "dbname"
  
  # PostGis 1.5 (use with versions 9.0, 9.1, 9.2)
  # postgresql9_postgis "dbname"
  
  # PostGis 2.0 (use with versions >= 9.2)
  #postgresql9_postgis2 "dbname"
  # postgresql9_seg "dbname"
  # postgresql9_sslinfo "dbname"
  # postgresql9_tablefunc "dbname"
  # postgresql9_test_parser "dbname"
  # postgresql9_unaccent "dbname"
  # postgresql9_uuid_ossp "dbname"
  
  
  # 9.1 and 9.2 Extensions
  # postgresql9_file_fdw "dbname"
  # postgresql9_xml2 "dbname"
  
  #9.2 Extensions
  # postgresql9_pg_stat_statements "dbname"
  
  # Admin-Level Contribs
  # postgresql9_pg_buffercache "postgres"
  # postgresql9_pg_freespacemap "postgres"
# end
