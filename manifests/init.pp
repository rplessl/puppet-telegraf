# == Class: telegraf
#
# Install the InfluxDBs telegraf
#
# === Parameters
#
# [*ensure*]
#   handle installation, activation or purging of telegraf
#   Defaults to <tt>present</tt>.
#
# [*version*]
#   String to set the specific version you want to install.
#   Defaults to <tt>0.13.1</tt>.
#
# [*download_package *]
#   Install telegraf with explicit download this version from InfluxData repository
#
# [*manage_repo*]
#   Enable repo management by enabling InfluxData official repositories
#
# [*config_template*]
#   path to the template (erb file) for base configuration of telegraf
#
# [*config_base_file*]
#   path to the base configuration file
#
# [*config_directory *]
#   path to the configuration directory (snippets)
#
# [*outputs_influxdb_enabled*]
#   Activate InfluxDB as a output sink
#
# [*outputs_influxdb_urls*]
#   URLs to output sinks InfluxDB
#
# [*outputs_influxdb_database*]
#   Database name of output sink InfluxDB
#
# [*outputs_influxdb_username*]
#   Username of output sink InfluxDB
#
# [*outputs_influxdb_password*]
#   Password of output sink InfluxDB
#
# [*tags*]
#   Tags given as a key / value pair slice
#
# [*agent_hostname*]
#   Configures agent hostname for sending it to the sinks
#
# [*agent_flush_interval*]
#   Configures agent flushing interval
#
# [*agent_interval*]
#   Configures agent fetching interval
#
# [*cpu_percpu*]
#   Configures system CPU plugin (percpu)
#
# [*cpu_totalcpu*]
#   Configures system CPU plugin (totalcpu)
#
# [*cpu_drop*]
#   Configures system CPU plugin (drop)
#
# [*disk_mountpoint*]
#   Configures system Disk plugin (mountpoints)
#
# === Authors
#
# Roman Plessl <roman.plessl@prunux.ch>
#
# === Copyright
#
# Copyright 2015-2016 Roman Plessl, Plessl + Burkhardt GmbH
# Copyright 2015-2016 Nine Internet Solutions AG
#
class telegraf (
  $ensure                     = $::telegraf::params::ensure,
  $version                    = $::telegraf::params::version,
  $download_package           = $::telegraf::params::download_package,
  $manage_repo                = $::telegraf::params::manage_repo,
  $config_template            = $::telegraf::params::config_template,
  $config_base_file           = $::telegraf::params::config_base_file,
  $config_directory           = $::telegraf::params::config_directory,

  # [outputs.influxdb] section of telegraf.conf
  $outputs_influxdb_enabled   = $::telegraf::params::outputs_influxdb_enabled,
  $outputs_influxdb_urls      = $::telegraf::params::outputs_influxdb_urls,
  $outputs_influxdb_database  = $::telegraf::params::outputs_influxdb_database,
  $outputs_influxdb_username  = $::telegraf::params::outputs_influxdb_username,
  $outputs_influxdb_password  = $::telegraf::params::outputs_influxdb_password,

  # [tags] section of telegraf.conf
  $tags                       = $::telegraf::params::tags,

  # [agent]
  $agent_hostname             = $::telegraf::params::agent_hostname,
  $agent_interval             = $::telegraf::params::agent_interval,
  $agent_flush_interval       = $::telegraf::params::agent_flush_interval,

  # [[plugins.cpu]]
  $cpu_percpu                 = $::telegraf::params::cpu_percpu,
  $cpu_totalcpu               = $::telegraf::params::cpu_totalcpu,
  $cpu_drop                   = $::telegraf::params::cpu_drop,

  # [[plugins.disk]]
  $disk_mountpoints           = $::telegraf::params::mountpoints

) inherits ::telegraf::params
{
  class { '::telegraf::install': }
  ->
  class { '::telegraf::config': }
  ~>
  class { '::telegraf::service': }
  ->
  class { '::telegraf::cleanup': }

  contain telegraf::install
  contain telegraf::config
  contain telegraf::service
  contain telegraf::cleanup

}
