# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

puppet_hostname="puppet.example.com"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise32"

  config.vm.hostname = puppet_hostname

  # Update version of puppet first
  config.vm.provision "shell", path: "bootstrap.sh"

  # Setup Puppet, r10k , hiera
  config.vm.provision "puppet" do |puppet|
    puppet.facter = {
      "gitrepo" => "https://github.com/gloppasglop/expertday-demo.git",
      "fqdn"    => puppet_hostname,
      "puppetmaster" => puppet_hostname,
    }
    puppet.manifests_path = "manifests"
#    puppet.hiera_config_path = "hiera.yaml"
    puppet.manifest_file  = "init.pp"
    puppet.module_path = "modules"
  end

  #config.vm.provision "shell", inline: "r10k deploy environment -p"


end
