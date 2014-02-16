VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest
  config.vm.hostname = "polipo-appliance"
  config.vm.box = "opscode-ubuntu-12.04"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box"
  config.vm.network :public_network
  # config.vm.provider :virtualbox do |p|
  #   p.name = "polipo-appliance"
  # end

  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "polipo_appliance"
    chef.json = {
      "polipo_appliance" => {
        "allowed_clients" => "192.168.0.0/16, 10.0.0.0/24"
      }
    }
  end
end


