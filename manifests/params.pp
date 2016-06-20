# == Class: telegraf::params
#
# Internal class.
#
# Configures default for telegraf
#
# === Authors
#
# Roman Plessl <roman.plessl@prunux.ch>
#
# === Copyright
#
# Copyright 2015-2016 Roman Plessl, Plessl + Burkhardt GmbH
#
class telegraf::params {
  $ensure                    = 'present'
  $version                   = '0.13.1'
  $download_package          = false
  $manage_repo               = true
  $config_template           = 'telegraf/telegraf.conf.erb'
  $config_base_file          = '/etc/telegraf/telegraf.conf'
  $config_directory          = '/etc/telegraf/telegraf.d'

  # [outputs.influxdb] section of telegraf.conf
  $outputs_influxdb_enabled  = true
  $outputs_influxdb_urls     = ['http://localhost:8086']
  $outputs_influxdb_database = 'telegraf'
  $outputs_influxdb_username = 'telegraf'
  $outputs_influxdb_password = 'metricsmetricsmetricsmetrics'

  # [tags] section of telegraf.conf
  $tags                      = undef

  # [agent]
  $agent_hostname            = $::hostname
  $agent_interval            = '10s'
  $agent_flush_interval      = '10s'

  # [[plugins.cpu]]
  $cpu_percpu                = true
  $cpu_totalcpu              = true
  $cpu_drop                  = ['time_*']

  # [[plugins.disk]]
  # The default value for this is NO value.
  $disk_mountpoints          = undef

}
