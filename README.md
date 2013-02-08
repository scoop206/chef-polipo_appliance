chef-polipo Cookbook
--------------------

[Polipo](http://www.pps.univ-paris-diderot.fr/~jch/software/polipo/) is a "a small and fast caching web proxy"  

This cookbook uses polipo to create an appliance VM for http caching.  
This can be useful for Vagrant testing if you are having to pull lots of RPMs and get tired of waiting for them to download on every converge.  

You can either use it standalone, or within a chef-repository.  
It is more convenient within a repo:  
chef clients with recipe\[polipo::client\_proxy\] in the run list will use HTTP caching.  

Requirements
------------

Vagrant


Attributes
----------

**node["polipo"]["proxy_ipaddress"]**

the polipo::client\_proxy recipe should be added high in the run list of the VM your are testing / converging.  
Once added it will use the node["polipo"]["proxy_ipaddress"] to set the proxy in /etc/yum.conf

**node["polipo"]["allowed_clients]**

the polipo::default recipe installs polipo to your appliance VM.  
This VM is setup with networking in bridged mode. 
The node["polipo"]["allowed_clients] attribute tells polipo who can use it a proxy.  
This defaults to an RFC-1918 (non routeable) address range.  


Usage
-----

1. clone the repo:  
`git clone git@github.com:sandfish8/chef-polipo.git`  

2. rename to polipo:  
`mv chef-polipo polipo`  

3. Install gems  
`cd polipo`  
`bundle install`

4. Before starting the VM, if your ip address is not within a private range, then update the allowed\_clients attribute in the Vagrantfile:  
`:polipo => {
   :allowed_clients => "YOUR_IP"
 } `

5. Start the VM  
`bundle exec vagrant up`

6. ssh into the polipo VM and get it's IP  
`bundle exec vagrant ssh`  
`ifconfig`

7. For each node that you'd like to utilize the proxy, you'll need to  

  * set the ipaddress in node["polipo"]["proxy_ipaddress"]
  * add recipe["polipo"]["proxy\_client"] to it's run list.


Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
6. Submit a Pull Request using Github

License and Authors
-------------------

Author:: [Sam Cooper][sandfish8] (<sam@chgworks.com>)

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
