# == Class: telegraf::plugins::opentsdb
#
# this plugin adds the OpenTSDB output plugin to telegraf
#
# IMPORTANT: please check the InfluxDB backend is disabled
#
# === Parameters
#
# [*opentsdb_server*]
#  opentsdb server
#
# [*opentsdb_port*]
#  opentsdb port
#
# [*opentsdb_prefix*]
#  opentsdb metric prefix
#
# === Examples
#
#  include telegraf::plugins::opentsdb
#
# === Authors
#
# Roman Plessl <roman.plessl@nine.ch>
#
# === Copyright
#
# Copyright 2015 Roman Plessl, Nine Internet Solutions AG
#
class telegraf::plugins::opentsdb (
  # [outputs.opentsdb] section of telegraf.conf
  $opentsdb_server = 'my.opentsdb.server.domain.com',
  $opentsdb_port   = 4242,
  $opentsdb_prefix = 'my.metrics.telegraf.',
){

  file { "${::telegraf::config_directory}/01-opentsdb.conf":
    ensure  => file,
    content => template('telegraf/plugins/01-opentsdb.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }

}
