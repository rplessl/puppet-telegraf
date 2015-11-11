# == Class: telegraf::plugins::mysql
#
# this plugin adds the MySQL input plugin to telegraf
#
# === Parameters
#
# === Examples
#
#  include telegraf::plugins::mysql
#
# === Authors
#
# Roman Plessl <roman.plessl@nine.ch>
#
# === Copyright
#
# Copyright 2015 Roman Plessl, Nine Internet Solutions AG
#
class telegraf::plugins::mysql (
  # [mysql] section of telegraf.conf
)
{

  file { "${telegraf::config_directory}/30-mysql.conf":
    ensure  => file,
    content => template('telegraf/plugins/30-mysql.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
  }

}
