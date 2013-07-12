#
# Cookbook Name:: dnsmasq
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "dnsmasq"

template "/usr/local/etc/dnsmasq.conf" do
  source "dnsmasq_conf.erb"
  mode 0644
  owner "kenjiskywalker"
end
