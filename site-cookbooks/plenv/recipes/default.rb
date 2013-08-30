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

execute "download-git" do
  user #{username}
  command <<-EOH
        git clone #{plenv_repo} /home/#{username}/.plenv
        git clone #{perl_build_repo} /home/#{username}/.plenv/plugins/perl-build/
  EOH
  notifies :run, "execute[setup-bashrc]"
  notifies :run, "execute[build-perl]"
  not_if { File.exist?("/home/#{username}/.plenv") }
end

execute "setup-bashrc" do
  user #{username}
  command <<-EOH
        echo 'export PATH="$HOME/.plenv/bin:$PATH"' >> /home/#{username}/.bashrc
        echo 'eval "$(plenv init -)"' >> /home/#{username}/.bashrc
  EOH
  action :nothing
end

execute "build-perl" do
  user #{username}
#  environment 'HOME' => "/home/#{username}"
  command <<-EOH
        /home/#{username}/.plenv/bin/plenv rehash
        /home/#{username}/.plenv/plugins/perl-build/bin/plenv-install #{version}
        /home/#{username}/.plenv/bin/plenv global #{version}
        /home/#{username}/.plenv/bin/plenv rehash
        /home/#{username}/.plenv/bin/plenv install-cpanm
        /home/#{username}/.plenv/bin/plenv rehash
  EOH
  action :nothing
end
