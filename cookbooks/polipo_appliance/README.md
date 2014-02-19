# chef-polipo

A cookbook wich configures polipo.
[Polipo](http://www.pps.univ-paris-diderot.fr/~jch/software/polipo/) is a "a small and fast caching web proxy"  

## Recipes

### default
purpose: configure a polipo proxy

Polipo needs to know what ip ranges to accept proxying requests from.  By default, this cookbook sets non-routable ip ranges as accepted.
If you would like a different range you'll need to modify the default["polipo_appliance"]["allowed_clients"] before bootstrapping the appliance.

### proxy_client
purpose: configure a sytem to use a caching proxy when downloading packages.

Each proxy client needs  
 - recipe["polipo_appliance::proxy_client]" at the top of their run list
 - node["polipo-appliance"]["proxy\_ipaddress"] set to the ip of the appliance.
