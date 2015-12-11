# == Class: telegraf::plugins::postgresql
#
# this plugin adds the PostgreSQL plugin to telegraf
#
# === Parameters
#
# [*address*]
#  Connection string to PostgreSQL DB.
#  default: Host -> localhost
#           User -> telegraf user
#           SSL -> disabled
#
# === Examples
#
#  include telegraf::plugins::postgresql
#
# === Authors
#
# Roman Plessl <roman.plessl@nine.ch>
#
# === Copyright
#
# Copyright 2015 Roman Plessl, Nine Internet Solutions AG
#
class telegraf::plugins::postgresql (
  # [postgresql] section of telegraf.conf
  # default
  $address = "sslmode=disable",
){

  file { "${telegraf::config_directory}/31-postgresql.conf":
    ensure  => file,
    content => template('telegraf/plugins/31-postgresql.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }

}
