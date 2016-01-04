# == Class: telegraf::plugins::elasticsearch
#
# this plugin adds the elasticsearch plugin to telegraf
#
# === Parameters
#
#
# === Examples
#
#  include telegraf::plugins::elasticsearch
#
# === Authors
#
# Asthon Davis
#
# === Copyright
#
# Copyright 2015 Asthon Davis
#
class telegraf::plugins::elasticsearch (
  $servers          = ['http://localhost:9200'],
  $cluster_health   = true,
  $local            = true,
){

  file { "${::telegraf::config_directory}/41-elasticsearch.conf":
    ensure  => file,
    content => template('telegraf/plugins/41-elasticsearch.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }

}
