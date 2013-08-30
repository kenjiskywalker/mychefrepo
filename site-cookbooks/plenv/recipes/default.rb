#
# Cookbook Name:: plenv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

username        = 'kenjiskywalker'
plenv_repo      = 'git://github.com/tokuhirom/plenv.git'
perl_build_repo = 'git://github.com/tokuhirom/Perl-Build.git'
version         = node['perl-build']['version']
homedir         = ENV["HOME"]

execute "download-git" do
  user #{username}
  command <<-EOH
        git clone #{plenv_repo} /#{homedir}/.plenv
        git clone #{perl_build_repo} /#{homedir}/.plenv/plugins/perl-build/
  EOH
  notifies :run, "execute[setup-bashrc]"
  notifies :run, "execute[build-perl]"
  not_if { File.exist?("/#{homedir}/.plenv") }
end

execute "setup-bashrc" do
  user #{username}
  command <<-EOH
        echo 'export PATH="$HOME/.plenv/bin:$PATH"' >> /#{homedir}/.bashrc
        echo 'eval "$(plenv init -)"' >> /#{homedir}/.bashrc
  EOH
  action :nothing
end

execute "build-perl" do
  user #{username}
  command <<-EOH
        /#{homedir}/.plenv/bin/plenv rehash
        /#{homedir}/.plenv/plugins/perl-build/bin/plenv-install #{version}
        /#{homedir}/.plenv/bin/plenv global #{version}
        /#{homedir}/.plenv/bin/plenv rehash
        /#{homedir}/.plenv/bin/plenv install-cpanm
        /#{homedir}/.plenv/bin/plenv rehash
  EOH
  action :nothing
end
