# == Class: telegraf::plugins::puppetagent
#
# this plugin adds the PuppetAgent plugin to telegraf
#
# === Parameters
#
# === Examples
#
#  include telegraf::plugins::puppetagent
#
# === Authors
#
# Roman Plessl <roman.plessl@prunux.ch>
#
# === Copyright
#
# Copyright 2015 Roman Plessl, Plessl + Burkhardt GmbH
#
class telegraf::plugins::puppetagent (
  # [puppetagent] section of telegraf.conf
){

  file { "${::telegraf::config_directory}/40-puppetagent.conf":
    ensure  => file,
    content => template('telegraf/plugins/40-puppetagent.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }

}
