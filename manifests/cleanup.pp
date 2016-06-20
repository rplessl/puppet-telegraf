# == Class: telegraf::cleanup
#
# cleanup the old files from previous telegraf versions
#
# === Authors
#
# Sebastian Nickel <nick@nine.ch>
# === Copyright
#
# Copyright 2015 Roman Plessl, Plessl + Burkhardt GmbH
#
class telegraf::cleanup {

  file {
    '/opt/telegraf':
      ensure  => absent,
      recurse => true,
      force   => true;
  }

  tidy {
    '/etc/telegraf':
      recurse => true,
      matches => [ 'telegraf.conf.dpkg-dist', 'telegraf.conf.*.backup' ];
  }
}
