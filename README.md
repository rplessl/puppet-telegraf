## Overview
[![Build Status](https://travis-ci.org/rplessl/puppet-telegraf.svg?branch=master)](https://travis-ci.org/rplessl/puppet-telegraf?branch=master)
[![rplessl-telegraf](https://img.shields.io/puppetforge/r/rplessl/telegraf.svg)](https://forge.puppetlabs.com/rplessl/telegraf)

This puppet module installs and manages the configuration of [InfluxData's Telegraf](https://github.com/influxdata/telegraf). A metrics collection agent.

Use this puppet module with Telegraf version 0.13.1 and newer.

This puppet module was designed and tested with Puppet 3.8.

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with telegraf](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with telegraf](#beginning-with-telegraf)
4.  [Development - Guide for contributing to the module](#development)
5.  [Testing - Guide to test the module](#testing)
    * [Testing Code with rspec tests](#testing-code-enhancement-rspec)
    * [Testing Code with Vagrant setup](#testing-setup-with-vagrant)
6.  [License](#License)

## Module Description

The module installs the telegraf package from the provided repositories and installs the basic configuration file and reconfigures this setup based on your whishes.

Supported Linux distributions are Debian based (Ubuntu, Debian) and RedHat based (CentOS, RHEL).

## Setup

### Setup Requirements

puppet-telegraf requires these third party puppet modules

  * [puppet-stdlibs](https://github.com/puppetlabs/puppetlabs-stdlib)
  * [wget](https://forge.puppetlabs.com/maestrodev/wget) module when the parameter `install_from_repository` is set to false.
  * [apt](https://github.com/puppetlabs/puppetlabs-apt (on Debian / Ubuntu)

### Beginning with telegraf

Include the class and set the necessary Telegraf and InfluxDB parameters.

```puppet
class { '::telegraf':
    version                   => '0.13.1',
    manage_repo               => true,
    config_template           => 'telegraf/telegraf.conf.erb',
    # [[outputs.influxdb]] section of telegraf.conf
    outputs_influxdb_enabled  => true,
    outputs_influxdb_urls     => ['http://influxdb-01.mydomain.com:8086', 'http://influxdb-02.mydomain.com:8086'],
    outputs_influxdb_database => 'telegraf',
    outputs_influxdb_username => 'telegraf',
    outputs_influxdb_password => 'metricsmetricsmetricsmetrics',
}
```

This puppet-telegraf module supports the following configuration options:

```puppet
class { '::telegraf':
    ensure                    => 'installed',
    version                   => '0.13.1',
    download_package          => false,
    manage_repo               => false,
    config_template           => 'telegraf/telegraf.conf.erb',
    config_base_file          => '/etc/telegraf/telegraf.conf',
    config_directory          => '/etc/telegraf/telegraf.d',

    # [[outputs.influxdb]] section of telegraf.conf
    outputs_influxdb_enabled  => true,
    outputs_influxdb_urls     => ['http://localhost:8086'],
    outputs_influxdb_database => 'telegraf',
    outputs_influxdb_username => 'telegraf',
    outputs_influxdb_password => 'metricsmetricsmetricsmetrics',

    # [tags] section of telegraf.conf
    tags                      => {
      virtual            => $::virtual,
      lsbdistdescription => $::lsbdistdescription,
      environment        => $::my_own_facter_environment,
      location           => $::my_own_facter_location,
    }

    # [agent]
    agent_hostname            => $::hostname,
    agent_interval            => '10s',

    # [[plugins.cpu]]
    cpu_percpu                => true,
    cpu_totalcpu              => true,
    cpu_drop                  => ["cpu_time"],

    # [[plugins.disk]]
    disk_mountpoints           = ["/","/home"],
}
```

### Plugins

The following plugins have been prepared for input / output configuration of Telegraf.

1. OpenTSDB
  ```puppet
  class { '::telegraf::plugins::outputs::opentsdb':
    opentsdb_server => 'my.opentsdb.server.domain.com',
    opentsdb_port   => 4242,
    opentsdb_prefix => 'my.metrics.telegraf.',
  }
  ```

2. MySQL
  ```puppet
  include '::telegraf::plugins::inputs::mysql'
  ```

3. PostgreSQL
  ```puppet
  include '::telegraf::plugins::inputs::postgresql'
  ```

4. PuppetAgent
  ```puppet
  include '::telegraf::plugins::inputs::puppetagent'
  ```

5. Elasticsearch
  ```puppet
  class { '::telegraf::plugins::inputs::elasticsearch': }
  ```

6. Procstats
  ```puppet
  class { '::telegraf::plugins::inputs::procstats': }
  ```

## Development

1. Fork it (https://github.com/rplessl/puppet-telegraf/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Wish: Make sure your Pull Requests passes the Rspec tests.

## Testing

### Testing Code Enhancement (rspec)

Testing is done with [rspec](http://rspec-puppet.com/).

### Testing Setup with Vagrant

Install and setup vagrant [https://docs.vagrantup.com/v2/installation/index.html](as described here).

Fetch virtual machines:
```ShellSession
vagrant box add puppetlabs/ubuntu-16.04-64-puppet --insecure
vagrant box add puppetlabs/ubuntu-14.04-64-puppet --insecure
vagrant box add puppetlabs/debian-7.8-64-puppet   --insecure
vagrant box add puppetlabs/debian-8.2-64-puppet   --insecure
vagrant box add puppetlabs/centos-7.2-64-puppet   --insecure
vagrant box add puppetlabs/centos-6.6-64-puppet   --insecure
```

Add vagrant puppet support and run tests:
```ShellSession
bundle install
bundle exec librarian-puppet install
vagrant up
```

## License

Licensed under the MIT License.

Copyright (c) 2015-2016 Roman Plessl (@rplessl), Nine Internet Solutions AG and

Copyright (c) 2015-2016 Roman Plessl (@rplessl), Plessl + Burkhardt GmbH

See [LICENSE](https://github.com/rplessl/puppet-telegraf/blob/master/LICENSE) File





