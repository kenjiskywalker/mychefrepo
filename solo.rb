homedir = ENV["HOME"]

file_cache_path           "/tmp/chef-solo"
data_bag_path             "#{homedir}/mychefrepo/data_bags"
encrypted_data_bag_secret "#{homedir}/mychefrepo/data_bag_key"
cookbook_path             [ "#{homedir}/mychefrepo/site-cookbooks",
                            "#{homedir}/mychefrepo/cookbooks" ]
role_path                 "#{homedir}/mychefrepo/roles"
