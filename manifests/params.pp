# == Class: telegraf::params
# DO NOT CALL DIRECTLY
class telegraf::params {
  $ensure                  = 'installed'
  $version                 = '0.1.4'
  $install_from_repository = true
  $config_file             = '/etc/opt/telegraf/telegraf.conf'

  # [influxdb] section of telegraf.conf
  $influxdb_url           = 'http://localhost:8086'
  $influxdb_database      = 'telegraf'
  $influxdb_username      = 'telegraf'
  $influxdb_password      = 'metricsmetricsmetricsmetrics'
  $influxdb_tags          = undef

  # [agent]
  $agent_hostname         = 'localhost'
}
