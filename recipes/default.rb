#
# Cookbook Name:: polipo
# Recipe:: default
#
# Copyright 2013, Bluebox
# Copyright 2013, Sam Cooper <sam@chgworks.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "polipo" do
  :install
end

service "polipo" do
  :nothing
end

template "/etc/polipo/config" do
  mode "0644"
  source "polipo_config"
  variables :allowed_clients => node["polipo"]["allowed_clients"]
  notifies :restart, "service[polipo]"
end
