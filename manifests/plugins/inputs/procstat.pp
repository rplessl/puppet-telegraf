# == define: telegraf::plugins::procstat
#
# this define measures statistics for a given application/daemon via the proc system. It will try to find the processes
# in the following order (so specify only one of those parameters):
#
# pid_file -> exec_name -> pattern -> user
#
# === Parameters
#
# [*pid_file*]
#   The PID file where we can get the PID for the daemon from.
#
# [*exec_name*]
#   Used with pgrep to find the process.
#
# [*pattern*]
#   Used with 'pgrep -f' to find the process (so match the full command line).
#
# [*user*]
#   Get all processes from this user.
#
# [*prefix*]
#   Used to identify the procstat metric. Naming of the metric will be: procstat_[prefix_]<type of metric>. (Default: $name)
#
# [*field_drop*]
#   If we do not want specific metrics to be included in the output we can specify them here.
#   For example to drop the cpu time stats use:
#   field_drop => '["cpu_time_*"]'
#
# [*base_path*]
#   The base path for the config file. (default: "/etc/telegraf/telegraf.d")
#
#
# === Examples
#
#  telegraf::plugins::inputs::procstat {
#    'mysql':
#      pid_file => '/var/run/mysqld/mysqld.pid';
#  }
#
# === Authors
#
# Nick <nick@nine.ch>
#
# === Copyright
#
# Copyright 2016 Nine Internet Solutions AG
#
define telegraf::plugins::inputs::procstat (
  $pid_file   = undef,
  $exec_name  = undef,
  $pattern    = undef,
  $user       = undef,
  $prefix     = $name,
  $field_drop = undef,
  $base_path  = '/etc/telegraf/telegraf.d',
)
{
  # we need one of pid, exec, pattern or user
  if $pid_file == undef and $exec_name == undef and $pattern == undef and $user == undef {
    fail ('Please specify one parameter for either pid_file, exec_name, pattern or user')
  }

  #include telegraf::plugins::procstat_base
  concat {
    "${base_path}/40-procstat-${prefix}.conf":
      notify => Service['telegraf'];
  }

  # write a header
  concat::fragment {
    "40-procstat-${prefix}.conf_HEADER":
      target  => "${base_path}/40-procstat-${prefix}.conf",
      order   => 00,
      content => "#THIS FILE IS MANAGED BY PUPPET AND WILL GET OVERWRITTEN\n";
  }

  # write the actual config
  concat::fragment {
    "telegraf::plugins::procstat::${name}":
      order   => 10,
      target  => "${base_path}/40-procstat-${prefix}.conf",
      content => template('telegraf/plugins/procstat.erb');
  }
}
