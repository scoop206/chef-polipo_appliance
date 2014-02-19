# Chef Polipo Appliance

[Polipo](http://www.pps.univ-paris-diderot.fr/~jch/software/polipo/) is a "a small and fast caching web proxy"  

This is a vagrant appliance that uses polipo for local caching of RPM and deb packages.  
You can use it when doing local testing with test-kitchen to speed up local converges.

## How much faster is it?

erlang install w/o caching:     83 sec  
erlang install w/ primed cache: 28 sec

## Supported Platforms

The appliance is Ubuntu.  The polipo::client_proxy recipe works on the Debian and RHEL platorm families.  

## Requirements

Vagrant 1.1+  
Virtual Box

## Usage

Get the cookbook

```bash
git clone git@github.com:sandfish8/chef-polipo_appliance.git
cd test/integration/cookbooks/polipo_appliance
./bootstrap.sh
```

The bootstrap script will start up the VM, configure the appliance, and report what it's IP is.  
You can then use <polipo applianceIP:8123> as an http caching endpoint.

## Test Kitchen

Check out the polipo-appliance's .kitchen.yml to see how you can use the polipo appliance in your own test-kitchen runs.
You should be able to extend the run_lists here to suit your own purposes.

To modify for your own purposes:
- update the proxy ip address at the top of the .kitchen.yml
- extend the run_list in your suites

```yaml
---
driver_plugin: vagrant
driver_config:
  require_chef_omnibus: true
proxy: &proxy 192.168.0.23

platforms:

- name: ubuntu-12.04
  driver_config:
    box: opscode-ubuntu-12.04
    box_url: http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box
  run_list:
  - recipe[polipo_appliance::client_proxy]
  - recipe[apt]
  attributes:
    polipo_appliance:
      proxy_ipaddress: *proxy

- name: centos-6.5
  driver_config:
    box: opscode-centos-6.5
    box_url: http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box
  run_list:
  - recipe[polipo_appliance::client_proxy]
  attributes:
    polipo_appliance:
      proxy_ipaddress: *proxy

suites:

- name: ubuntu
  run_list: []
  excludes:
  - centos-6.5

- name: centos
  run_list: []
  excludes:
  - ubuntu-12.04
```

## Cookbooks

### polipo_appliance

see the README in the cookbook itself in cookbooks/polipo_appliance

## Troubleshooting

Since polipo is an HTTP proxy you can test the appliance using your browser.  Use your appliance's IP and target port 8123.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Run the tests
6. Submit a Pull Request using Github

## License and Authors

Author: Sam Cooper <sam@chgworks.com.

Copyright:: 2013, Sam Cooper

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
