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
# Copyright 2015 Roman Plessl, Plessl + Burkhardt GmbH
#
class telegraf::service {
  $service_ensure = $::telegraf::ensure
  case $service_ensure {
    true: {
      $my_service_ensure = 'running'
    }
    false: {
      $my_service_ensure = 'stopped'
    }
    'absent','purged': {
      $my_service_ensure = 'stopped'
    }
    'ensure','present','installed': {
      $my_service_ensure = 'running'
    }
    default: {
      $my_service_ensure = 'running'
    }
  }

  # use systemd for Debian jessie
  case $::lsbdistcodename {
    'jessie': {
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
