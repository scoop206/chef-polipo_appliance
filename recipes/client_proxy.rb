#
# Cookbook Name:: polipo
# Recipe:: default
#
# Copyright 2013, Bluebox
#
# All rights reserved - Do Not Redistribute
#

case node["platform_family"]
when 'rhel', 'fedora'

  template '/etc/yum.conf' do
    source 'proxied_yum.conf'
    mode '0644'
  end

when 'debian'
end
