# == Class: telegraf::config
#
# only values which are effectivly changed will be managed
#
# More information on these settings available at:
#    https://github.com/influxdb/telegraf
#
# DO NO CALL DIRECTLY
class telegraf::config {

  file { $telegraf::config_base_file:
    ensure  => file,
    content => template($::telegraf::config_template),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
  }

  file { $telegraf::config_directory:
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'telegraf',
  }

}
