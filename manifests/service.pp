# == Class: telegraf::service
# DO NO CALL DIRECTLY
class telegraf::service {
  $service_ensure = $telegraf::ensure
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
  service { 'telegraf':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    status     => '/usr/bin/pgrep -u telegraf -f "/opt/telegraf/telegraf "'
  }
}
