# == Class: telegraf
class telegraf (
  $ensure                   = $telegraf::params::ensure,
  $version                  = $telegraf::params::version,
  $install_from_repository  = $telegraf::params::install_from_repository,
  $config_file              = $telegraf::params::config_file,
  $influxdb_url             = $telegraf::params::influxdb_url,
  $influxdb_database        = $telegraf::params::influxdb_database,
  $influxdb_username        = $telegraf::params::influxdb_username,
  $influxdb_password        = $telegraf::params::influxdb_password,
  $influxdb_tags            = $telegraf::params::influxdb_tags,
  $agent_hostname           = $telegraf::params::agent_hostname,
) inherits telegraf::params {

  class { 'telegraf::install': } ->
  class { 'telegraf::config': }  ~>
  class { 'telegraf::service': } ->
  Class['telegraf']
}
