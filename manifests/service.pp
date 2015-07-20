# == Class: telegraf::service
# DO NO CALL DIRECTLY
class telegraf::service {
  service { 'telegraf':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    status     => '/usr/bin/pgrep -u telegraf -f "/opt/telegraf/telegraf "'
  }
}
