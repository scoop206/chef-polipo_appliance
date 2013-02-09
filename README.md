chef-polipo Cookbook
--------------------

[Polipo](http://www.pps.univ-paris-diderot.fr/~jch/software/polipo/) is a "a small and fast caching web proxy"  

This cookbook uses polipo to create an appliance VM for local caching of RPM and deb packages.  
This can save time when using Vagrant to test and you are converging again and again.

You can either use it standalone, or within a chef repository.  
It is more convenient within a repo, and is even more convenient if you use it with [Jamie](http://github.com/jamie-ci).  

Any chef clients with recipe\[polipo::client\_proxy\] in their run list will proxy their package downloads via the polipo appliance.  


Supported Platforms
-------------------

The appliance is Ubuntu.  The client_proxy recipe works on Debian and RHEL platorm families.  

Requirements
------------

Vagrant


Attributes
----------

**node["polipo"]["proxy_ipaddress"]**

The polipo proxy's ip address

**node["polipo"]["allowed_clients]**  
The IP ranges that the polipo appliance will provide caching for.  
By default the 10.x.x.x and 192.168.x.x non-routable ranges are used.

Recipes
--------

**polipo::default**  
Installs polipo to your appliance VM.  


**polipo::client\_proxy**  
Configures yum or apt to use polipo for proxying

Usage
-----

Get the cookbook

either clone by hand to a cookbook folder:  
```bash
git clone git@github.com:sandfish8/chef-polipo.git
```

or

add a group entry to your Berksfile and vendor the cookbook  (recommended)  
  
```ruby
group :polipo do
 cookbook 'polipo', :git => 'git://github.com/sandfish8/chef-polipo.git'
end
```

```bash
berks install -o polipo --path test/integration/cookbooks/
```

Run the polipo appliance bootstrap script and record the appliance ipaddress it spits out.  The VM's network runs bridged so you may get asked by Vagrant which network you'd like to bridge to.

Note: Polipo needs to know what ip ranges to accept proxying requests from.  By default, this cookbook sets non-routable ip ranges as accepted.
If you would like a different range you'll need to modify the default["polipo"]["allowed_clients"] before bootstrapping the appliance.
 
```bash
cd test/integration/cookbooks/polipo
./bootstrap.sh
```

Place the polipo information where your chef clients can get to it.  
This can be accomplished with either Jamie or Vagrant

Each proxy client needs  
 - recipe["polipo"]["proxy\_client"] at the top of their run list
 - node["polipo"]["proxy\_ipaddress"] set to the ip of the appliance.

An example .jamie.yml configuraiton

```yaml
---
driver_plugin: vagrant
platforms:
- name: ubuntu-12.04
  driver_config:
    box: opscode-ubuntu-12.04
    box_url: https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box
  run_list:
  - recipe[polipo::client_proxy]
  - recipe[apt]
- name: centos-6.3
  driver_config:
    box: opscode-centos-6.3
    box_url: https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-centos-6.3.box
  run_list:
  - recipe[polipo::client_proxy]
  - recipe[yum::epel]
suites:
- name: default
  run_list: []
  attributes:
    polipo:
      proxy_ipaddress: 192.168.0.53
```

Fire up your test VMs and they should now be using the polipo appliance for caching.

Troubleshooting
---------------

Since polipo is an HTTP proxy you can test the appliance using your browser.  Use your appliance's IP and target port 8123.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
6. Submit a Pull Request using Github

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
