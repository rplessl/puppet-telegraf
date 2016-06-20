# == Class: telegraf::plugins::powerdns
#
# this plugin adds the PowerDNS input plugin to telegraf
#
# === Parameters
#
# === Examples
#
#  include telegraf::plugins::powerdns
#
# === Authors
#
# Roman Plessl <roman.plessl@prunux.ch>
#
# === Copyright
#
# Copyright 2015 Roman Plessl, Plessl + Burkhardt GmbH
#
class telegraf::plugins::powerdns (
  # [powerdns] section of telegraf.conf
  $socket = '/var/run/pdns.controlsocket'
)
{

  file { "${::telegraf::config_directory}/53-powerdns.conf":
    ensure  => file,
    content => template('telegraf/plugins/53-powerdns.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }

}
