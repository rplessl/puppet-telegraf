# == Class: telegraf::service
# DO NO CALL DIRECTLY
class telegraf::service {
  $service_ensure = $telegraf::service_ensure
  case $service_ensure {
    true: {
      $my_service_ensure = 'running'
    }
    false: {
      $my_service_ensure = 'stopped'
    }
    default: {
      $my_service_ensure = $service_ensure
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
    ensure     => $my_service_ensure,
    enable     => true,
    hasrestart => true,
    provider   => $provider,
  }
}
