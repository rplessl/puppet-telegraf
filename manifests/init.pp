# == Class: telegraf
#
# Install the InfluxDBś telegraf
#
# === Parameters
#
# [*ensure*]
#  handle installation, activation or purging of telegraf
#
# [*version*]
#  handle version of telegraf
#
# [*install_from_repository *]
#  Install telegraf from official repository
#
# [*config_file*]
#  path to the configuration file
#
# [*outputs_influxdb_url*]
#  URL to output sink InfluxDB
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
# [*tags*]
#  Tags given as a key / value pair slice
#
# [*agent_hostname*]
#  Configures agent hostname for sending it to the sinks
#
# [*plugins*]
#  Hash of plugins to enable and any relevant options
#
class telegraf (
  $ensure                    = 'installed',
  $version                   = '0.1.5',
  $install_from_repository   = true,
  $config_file               = '/etc/opt/telegraf/telegraf.conf',

  # [outputs.influxdb] section of telegraf.conf
  $outputs_influxdb_url      = 'http://localhost:8086',
  $outputs_influxdb_database = 'telegraf',
  $outputs_influxdb_username = 'telegraf',
  $outputs_influxdb_password = 'metricsmetricsmetricsmetrics',

  # [tags] section of telegraf.conf
  $tags                      = undef,

  # [agent]
  $agent_hostname            = 'localhost',

  # plugins
  $plugins                   = undef,
)
{
  class { 'telegraf::install': } ->
  class { 'telegraf::config': } ~>
  class { 'telegraf::service': } ->
  Class['telegraf']
}
