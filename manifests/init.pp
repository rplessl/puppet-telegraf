# == Class: telegraf
#
# Install the InfluxDBs telegraf
#
# === Parameters
#
# [*ensure*]
#  handle installation, activation or purging of telegraf
#
# [*version*]
#  handle version of telegraf
#
# [*install_from_repository*]
#  Install telegraf from official repository
#
# [*manage_influx_repo*]
#  Add the official Influx repository
#
# [*config_base_file*]
#  path to the base configuration file
#
# [*config_directory *]
#  path to the configuration directory (snippets)
#
# [*outputs_influxdb_enabled*]
#  Activate InfluxDB as a output Plugin
#
# [*outputs_influxdb_urls*]
#  URLs to output sinks InfluxDB
#
# [*outputs_influxdb_database*]
#  Database name of output sink InfluxDB
#
# [*outputs_influxdb_username*]
#  Username of output sink InfluxDB
#
# [*outputs_influxdb_password*]
#  Password of output sink InfluxDB
#
# [*outputs_influxdb_precision*]
#  Configures the influxdb output precision
#
# [*tags*]
#  Tags given as a key / value pair slice
#
# [*agent_hostname*]
#  Configures agent hostname for sending it to the sinks
#
# [*agent_collection_interval*]
#  Configures agent collection interval
#
# [*agent_flush_interval*]
#  Configures agent flush interval

class telegraf (
  $ensure                    = 'installed',
  $version                   = '0.2.0',
  $install_from_repository   = true,
  $manage_influx_repo        = false,
  $config_base_file          = '/etc/opt/telegraf/telegraf.conf',
  $config_directory          = '/etc/opt/telegraf/telegraf.d',

  # [outputs.influxdb] section of telegraf.conf
  $outputs_influxdb_enabled   = true,
  $outputs_influxdb_urls      = ['http://localhost:8086'],
  $outputs_influxdb_database  = 'telegraf',
  $outputs_influxdb_username  = 'telegraf',
  $outputs_influxdb_password  = 'metricsmetricsmetricsmetrics',
  $outputs_influxdb_precision = 's',

  # [tags] section of telegraf.conf
  $tags                      = undef,

  # [agent]
  $agent_hostname            = $::hostname,
  $agent_collection_interval = '10s',
  $agent_flush_interval      = '10s',
)
{
  class { 'telegraf::install': }
  ->
  class { 'telegraf::config': }
  ~>
  class { 'telegraf::service': }
  ->
  Class['telegraf']
}
