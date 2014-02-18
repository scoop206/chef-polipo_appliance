# Chef Polipo Appliance

[Polipo](http://www.pps.univ-paris-diderot.fr/~jch/software/polipo/) is a "a small and fast caching web proxy"  

This is a vagrant appliance that uses polipo for local caching of RPM and deb packages.  

## Usage

Get the cookbook

```bash
git clone git@github.com:sandfish8/chef-polipo_appliance.git
```

Run the polipo appliance bootstrap script and record the appliance ipaddress it spits out.  The VM's network runs bridged so you may get asked by Vagrant which network you'd like to bridge to.

Note: Polipo needs to know what ip ranges to accept proxying requests from.  By default, this cookbook sets non-routable ip ranges as accepted.
If you would like a different range you'll need to modify the default["polipo_appliance"]["allowed_clients"] before bootstrapping the appliance.
 
```bash
cd test/integration/cookbooks/polipo_appliance
./bootstrap.sh
```

Place the polipo appliance information where your chef clients can get to it.  

Each proxy client needs  
 - recipe["polipo_appliance"]["proxy\_client"] at the top of their run list
 - node["polipo-appliance"]["proxy\_ipaddress"] set to the ip of the appliance.

An example .kitchen.yml configuraiton

```yaml
---
driver_plugin: vagrant
platforms:
- name: ubuntu-12.04
  driver_config:
    box: opscode-ubuntu-12.04
    box_url: https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box
  run_list:
  - recipe[polipo_appliance::client_proxy]
  - recipe[apt]
- name: centos-6.3
  driver_config:
    box: opscode-centos-6.3
    box_url: https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-centos-6.3.box
  run_list:
  - recipe[polipo_appliance::client_proxy]
  - recipe[yum::epel]
suites:
- name: default
  run_list: []
  attributes:
    polipo_appliance:
      proxy_ipaddress: 192.168.0.53
```

Fire up your test VMs and they should now be using the polipo appliance for caching.

## How much faster is it?

erlang install w/o caching:     83 sec  
erlang install w/ primed cache: 28 sec

## Supported Platforms

The appliance is Ubuntu.  The client_proxy recipe works on the Debian and RHEL platorm families.  

## Requirements

Vagrant 1.1+

## Attributes

**node["polipo_appliance"]["proxy_ipaddress"]**

The polipo proxy's ip address

**node["polipo_appliance"]["allowed_clients]**  
The IP ranges that the polipo appliance will provide caching for.  
By default the 10.x.x.x and 192.168.x.x non-routable ranges are used.

## Recipes

**polipo_appliance::default**  
Installs polipo to your appliance VM.  

**polipo_appliance::client\_proxy**  
Configures yum or apt to use polipo for proxying

## Troubleshooting

Since polipo is an HTTP proxy you can test the appliance using your browser.  Use your appliance's IP and target port 8123.

## Testing
```bash
rake test
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Run the tests
6. Submit a Pull Request using Github

Testing
-------------------

chef-polipo-appliance relies on the polipo-appliance cookbook.
polipo_appliance::client_proxy will setup a client to use the polipo proxy.  It does this by modifying either the apt or yum conf to use the proxy IP address.

( This logic needs to be broken out into it's own cookbook.  It shouldn't be in polipo-appliance.  It should be in another cookbook called something like chef-polipo)



License and Authors
-------------------

Author: Sam Cooper <sam@chgworks.com.

Copyright:: 2013, [Bluebox](http://bluebox.net)  
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
