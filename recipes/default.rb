#
# Cookbook Name:: gatling
# Recipe:: default
#
# Copyright 2014, Joe Richards
#

include_recipe 'java'
include_recipe 'ark'

gatling_user_files    = "#{node['gatling']['install_prefix']}/gatling-#{node['gatling']['version']}/user-files"
gatling_bin           = "#{node['gatling']['install_prefix']}/gatling-#{node['gatling']['version']}/bin"
gatling_conf          = "#{node['gatling']['install_prefix']}/gatling-#{node['gatling']['version']}/conf"
gatling_results       = "#{node['gatling']['install_prefix']}/gatling-#{node['gatling']['version']}/results"

group node['gatling']['group']

user node['gatling']['user'] do
    supports :manage_home => false
    group node['gatling']['group']
    shell "/bin/bash"
    home "/home/gatling"
end

ark 'gatling' do
    url node['gatling']['download_url']
    version node['gatling']['version']
    prefix_root node['gatling']['install_prefix']
    append_env_path true
    owner 'gatling'
end

execute "fixup #{gatling_bin}" do
    command "chown -R #{node['gatling']['user']}:#{node['gatling']['group']} #{gatling_bin}"
    only_if { Etc.getpwuid(File.stat(gatling_bin).uid).name != node['gatling']['user'] }
end

directory gatling_user_files do
    mode 0755
    owner node['gatling']['user']
    group node['gatling']['group']
    action :create
end

directory gatling_bin do
    mode 0755
    owner node['gatling']['user']
    group node['gatling']['group']
    action :create
end

directory gatling_results do
    mode 0755
    owner node['gatling']['user']
    group node['gatling']['group']
    action :create
end

directory gatling_conf do
    mode 0755
    owner node['gatling']['user']
    group node['gatling']['group']
    action :create
end

cookbook_file "#{gatling_conf}/logback.xml" do
    source "logback.xml"
    mode 0755
    owner node['gatling']['user']
    group node['gatling']['group']
end
