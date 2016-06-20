# == Class: telegraf::service
#
# Internal class.
#
# Configures services for telegraf
#
# === Authors
#
# Roman Plessl <roman.plessl@prunux.ch>
#
# === Copyright
#
# Copyright 2015-2016 Roman Plessl, Plessl + Burkhardt GmbH
#
class telegraf::service {
  $service_ensure = $::telegraf::ensure ? {
    true              => 'running',
    false             => 'stopped',
    /(absent|purged)/ => 'stopped',
    default           => 'running',
  }

  # use systemd for newer Debian/Ubuntu distributions
  case $::lsbdistcodename {
    'jessie': {
      $provider = 'systemd'
    }
    'xenial': {
      $provider = 'systemd'
    }
    default: {
      $provider = undef
    }
  }

  service { 'telegraf':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    provider   => $provider,
  }
}
