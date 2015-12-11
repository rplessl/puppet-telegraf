# == Class: telegraf::plugins::elasticsearch
#
# this plugin adds the elasticsearch plugin to telegraf
#
# === Parameters
#
# [*servers*]
#  Elasticsearch servers as a string: list of one or more Elasticsearch servers
#
# [*cluster_health]
#  Boolean: default true.
#  If true, it will also obtain cluster level stats.
#
# [*local*]
#  Boolean: default true.
#  If false, it will read the indices stats from all nodes.
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
  # [elasticsearch] section of telegraf.conf
  $servers          = ["http://localhost:9200"],
  $cluster_health   = true,
  $local            = true,
){

  file { "${telegraf::config_directory}/41-elasticsearch.conf":
    ensure  => file,
    content => template('telegraf/plugins/41-elasticsearch.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'telegraf',
    notify  => Service['telegraf'];
  }

}
