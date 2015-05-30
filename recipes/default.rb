#
# Cookbook Name:: gatling
# Recipe:: default
#
# Copyright 2014, Joe Richards
#

include_recipe 'java'
include_recipe 'ark'
include_recipe 'sysctl'

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

user_ulimit node['gatling']['user'] do
    filehandle_limit    300000
    process_limit       300000
end

sysctl_param 'net.ipv4.tcp_fin_timeout' do
    value 15
    action :apply
end

sysctl_param 'net.ipv4.ip_local_port_range' do
    value '1025 65535'
    action :apply
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

template "#{gatling_conf}/gatling.conf" do
    source "gatling.conf.erb"
    owner node['gatling']['user']
    group node['gatling']['group']
    variables({
        :gatling_results     => gatling_results,
        :gatling_user_files  => gatling_user_files
    })
end

cookbook_file "#{gatling_conf}/logback.xml" do
    source "logback.xml"
    mode 0755
    owner node['gatling']['user']
    group node['gatling']['group']
end
