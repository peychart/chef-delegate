#
# Cookbook Name:: chef-delegate
# Recipe:: default
#
# Copyright (C) 2014 PE, pf.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

%w[ wget openssl zlib1g ].each do |pack|
  package pack do
    action :upgrade
  end
end

bash "get" do
  code "cd /usr/local/sbin && wget #{node['chef-delegate']['url']}/#{node['platform']}-#{node['platform_version']}/delegated && chmod 755 delegated"
  not_if { ::File.exists?("/usr/local/sbin/delegated") }
end

i=1; while i do
  i = node['chef-delegate']['paramsFilePath'].sub(/\/$/, '').index('/', i)
  if i
    filename = node['chef-delegate']['paramsFilePath'][0..i]; i += 1
  else
    filename = node['chef-delegate']['paramsFilePath']
  end
  directory filename do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

options = Array.new(node['chef-delegate']['options'])
node['chef-delegate'].each do |name, v|
  if (v.is_a? Hash) && (v['rules'].is_a? Array) && (v['callOptions'].is_a? String) && !v['callOptions'].empty?

    options << v['callOptions'].sub(/\"$/, '').sub(/:$/, '') + ':+=' + node['chef-delegate']['paramsFilePath'].sub(/\/$/, '') + "/#{name}" + (v['callOptions'].index('"')?'"':'')

    template node['chef-delegate']['paramsFilePath'].sub(/\/$/, '') + "/#{name}" do
      source 'confile.erb'
      owner 'root'
      group 'root'
      mode 0644
      variables({
        :rules => v['rules']
      })
    end

  end
end

template '/etc/init.d/delegate' do
  source 'delegate.erb'
  owner 'root'
  group 'root'
  mode 0755
  variables({
    :options => options
  })
  notifies :restart, 'service[delegate]', :immediately
end

service 'delegate' do
  action [ :enable, :restart ]
end

