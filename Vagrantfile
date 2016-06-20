# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'puppet-telegraf'

  config.vm.box_download_insecure = true

  config.vm.synced_folder "modules", "/tmp/puppet-modules",          type: "rsync", rsync__exclude: ".git/"
  config.vm.synced_folder ".",       "/tmp/puppet-modules/telegraf", type: "rsync", rsync__exclude: ".git/"

  config.vm.define "xenial", primary: true do |xenial|
    xenial.vm.box = "puppetlabs/ubuntu-16.04-64-puppet"
    xenial.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file  = "vagrant.pp"
      puppet.options        = ["--modulepath", "/tmp/puppet-modules"]
    end
  end

  config.vm.define "trusty", primary: true do |trusty|
    trusty.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
    trusty.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file  = "vagrant.pp"
      puppet.options        = ["--modulepath", "/tmp/puppet-modules"]
    end
  end

  config.vm.define "wheezy", autostart: false do |wheezy|
    debian.vm.box = "puppetlabs/debian-7.8-64-puppet"
    debian.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file  = "vagrant.pp"
      puppet.options        = ["--modulepath", "/tmp/puppet-modules"]
    end
  end

  config.vm.define "jessie", autostart: false do |jessie|
    debian.vm.box = "puppetlabs/debian-8.2-64-puppet"
    debian.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file  = "vagrant.pp"
      puppet.options        = ["--modulepath", "/tmp/puppet-modules"]
    end
  end

  config.vm.define "centos6", autostart: false do |centos6|
    centos6.vm.box = "puppetlabs/centos-6.6-64-puppet"
    centos6.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file  = "vagrant.pp"
      puppet.options        = ["--modulepath", "/tmp/puppet-modules"]
    end
  end

  config.vm.define "centos7", autostart: false do |centos7|
    centos7.vm.box = "puppetlabs/centos-7.2-64-puppet"
    centos7.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file  = "vagrant.pp"
      puppet.options        = ["--modulepath", "/tmp/puppet-modules"]
    end
  end

end
