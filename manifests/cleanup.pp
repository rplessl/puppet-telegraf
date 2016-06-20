# == Class: telegraf::cleanup
#
# cleanup the old files from previous telegraf versions
#
# === Authors
#
# Nick (github.com/thirdeyenick)
#
# === Copyright
#
# Copyright 2016 Nine Internet Solutions AG
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
