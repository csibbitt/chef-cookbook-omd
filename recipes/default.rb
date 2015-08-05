#
# Cookbook Name:: omd
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'apt'

#dpkg_package won't install deps for me :-(
%w(libapache2-mod-python libapache2-mod-php5 php5-sqlite php5-mcrypt libgd2-xpm libdbi0 libapache2-mod-proxy-html).each do |p|
  package p
end

pkg_cache_path = File.join(Chef::Config[:file_cache_path], File.basename(node['omd']['package_url']))

remote_file pkg_cache_path do
  source node['omd']['package_url']
end

dpkg_package 'omd' do
  source pkg_cache_path
end

#node['omd']['managed_sites'].each do |site|
#  omd_site site['name']
##Creates site and automation user
#
#  ( site['hosts_static'] | search(:node, site['hosts_searchstring']) ).each do |host|
#    omd_wato_host host['name'] do
#      site site
#      extra_tags host['omd']['tags'] 
#    end
#  end
#
#end
