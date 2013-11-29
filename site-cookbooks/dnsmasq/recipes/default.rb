#
# Cookbook Name:: dnsmasq
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user = "kenjiskywalker"
homedir = "/Users/kenjiskywalker"

package "dnsmasq" do
  notifies :run, "execute[cp-mxcl]"
end

template "/usr/local/etc/dnsmasq.conf" do
  source "dnsmasq_conf.erb"
  mode 0644
  owner "#{user}"
end

template "/etc/resolv.dnsmasq.conf" do
  source "resolv_dnsmasq_conf.erb"
  mode 0644
  owner "#{user}"
end

execute "cp-mxcl" do
  command "cp /usr/local/opt/dnsmasq/homebrew.mxcl.dnsmasq.plist  /Library/LaunchDaemons/"
  action :nothing
end

cookbook_file "dnsmasq.sh" do
  path "#{homedir}/bin/dnsmasq.sh"
  action :create_if_missing
  mode 0755
  owner "#{user}"
  only_if {File.exists?("#{homedir}/bin/")}
end

