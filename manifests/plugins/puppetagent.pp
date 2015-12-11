# == Class: telegraf::plugins::puppetagent
#
# this plugin adds the PuppetAgent plugin to telegraf
#
# === Parameters
#
# [*location*]
#  Path and filename of the latest run information of puppet
#
# === Examples
#
#  include telegraf::plugins::puppetagent
#
# === Authors
#
# Roman Plessl <roman.plessl@nine.ch>
#
# === Copyright
#
# Copyright 2015 Roman Plessl, Nine Internet Solutions AG
#
class telegraf::plugins::puppetagent (
  # [puppetagent] section of telegraf.conf
  $location = '/var/lib/puppet/state/last_run_summary.yaml',
){

  file { "${telegraf::config_directory}/40-puppetagent.conf":
    ensure  => file,
    content => template('telegraf/plugins/40-puppetagent.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }

}
