# == Class: telegraf::config
#
# only values which are effectivly changed will be managed
#
# More information on these settings available at:
#    https://github.com/influxdb/telegraf
#
# DO NO CALL DIRECTLY
class telegraf::config {

  file { "${telegraf::config_base_file}":
    ensure  => file,
    content => template('telegraf/telegraf.conf.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'telegraf',
  }

  file { "${telegraf::config_directory}":
    ensure => directory,
    mode   => '0750',
    owner  => 'root',
    group  => 'telegraf',
  }

}
