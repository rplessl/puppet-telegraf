# == Class: telegraf::config
#
# only values which are effectivly changed will be managed
# More information on these settings available at:
#   https://telegraf.com/docs/v0.9/administration/config.html
#
# DO NO CALL DIRECTLY
class telegraf::config {

  # defaults for all settings
  Ini_setting {
    ensure  => present,
    path    => $telegraf::config_file,
  }

  # [influxdb]
  ini_setting { 'influxdb_url':
    section => 'influxdb',
    setting => 'url',
    value   => "\"${telegraf::influxdb_url}\"",
  }

  ini_setting { 'influxdb_database':
    section => 'influxdb',
    setting => 'database',
    value   => "\"${telegraf::influxdb_database}\"",
  }

  ini_setting { 'influxdb_username':
    section => 'influxdb',
    setting => 'username',
    value   => "\"${telegraf::influxdb_username}\"",
  }

  ini_setting { 'influxdb_password':
    section => 'influxdb',
    setting => 'password',
    value   => "\"${telegraf::influxdb_password}\"",
  }

  if $telegraf::influxdb_tags != undef {
    ini_setting { 'influxdb_tags':
      section => 'influxdb',
      setting => 'tags',
      value   => $telegraf::influxdb_tags,
    }
  }

  # [agent]
  ini_setting { 'agent_hostname':
    section => 'agent',
    setting => 'hostname',
    value   => "\"${telegraf::agent_hostname}\"",
  }

}
