# == Class: telegraf::plugins::inputs::powerdns
#
# this plugin adds the PowerDNS input plugin to telegraf
#
# === Parameters
#
# === Examples
#
#  include telegraf::plugins::include::powerdns
#
# === Authors
#
# Marius Rieder <marius.rieder@nine.ch>
#
# === Copyright
#
# Copyright 2016 Nine Internet Solutions AG
#
class telegraf::plugins::powerdns (
  # [powerdns] section of telegraf.conf
  $socket = '/var/run/pdns.controlsocket'
)
{

  file { "${::telegraf::config_directory}/53-powerdns.conf":
    ensure  => file,
    content => template('telegraf/plugins/inputs/53-powerdns.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }

}
