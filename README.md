# puppet-telegraf

[![Build Status](https://travis-ci.org/rplessl/puppet-telegraf.png)](https://travis-ci.org/rplessl/puppet-telegraf)

## Description

puppet module to install and configure [telegraf](https://github.com/influxdb/telegraf) (version 0.2.0 and newer).

## Installation

`puppet module install --modulepath /path/to/puppet/modules puppet-telegraf`

## Usage

`class { 'telegraf': }`

These configuration parameter can be set:
```
class telegraf (
  $ensure                    = 'installed',
  $version                   = '0.2.0',
  $install_from_repository   = true,
  $config_base_file          = '/etc/opt/telegraf/telegraf.conf',
  $config_directory          = '/etc/opt/telegraf/telegraf.d',

  # [outputs.influxdb] section of telegraf.conf
  $outputs_inflxudb_enabled  = true,
  $outputs_influxdb_urls     = ['http://localhost:8086'],
  $outputs_influxdb_database = 'telegraf',
  $outputs_influxdb_username = 'telegraf',
  $outputs_influxdb_password = 'metricsmetricsmetricsmetrics',

  # [tags] section of telegraf.conf
  $tags                      = undef,

  # [agent]
  $agent_hostname            = 'localhost',
)
```

## Testing

Install and setup vagrant [https://docs.vagrantup.com/v2/installation/index.html](as described here).

Fetch virtual machines:
```ShellSession
vagrant box add puppetlabs/ubuntu-14.04-64-puppet --insecure
vagrant box add puppetlabs/centos-6.6-64-puppet   --insecure
vagrant box add puppetlabs/centos-7.0-64-puppet   --insecure
vagrant box add puppetlabs/debian-7.8-64-puppet   --insecure
vagrant box add markusperl/debian-8.0-jessie-64-shrinked-puppet --insecure
```

Add vagrant puppet support and run tests:
```ShellSession
bundle install
bundle exec librarian-puppet install
vagrant up
```
