# == Class: telegraf::plugins::postgresql
#
# this plugin adds the PostgreSQL plugin to telegraf
#
# === Parameters
#
#
# === Examples
#
#  include telegraf::plugins::postgresql
#
# === Authors
#
# Roman Plessl <roman.plessl@prunux.ch>
#
# === Copyright
#
# Copyright 2015 Roman Plessl, Plessl + Burkhardt GmbH
#
class telegraf::plugins::postgresql (
  # [postgresql] section of telegraf.conf
){

  file { "${::telegraf::config_directory}/31-postgresql.conf":
    ensure  => file,
    content => template('telegraf/plugins/31-postgresql.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }

}
