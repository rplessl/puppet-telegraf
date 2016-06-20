# == Class: telegraf::install
#
# This class is called from telegraf for install.
#
# === Authors
#
# Roman Plessl <roman.plessl@prunux.ch>
#
# === Copyright
#
# Copyright 2015-2016 Roman Plessl, Plessl + Burkhardt GmbH
#
class telegraf::install {

  if ($::telegraf::download_package == true and  $::telegraf::manage_repo == true) {
    fail('only one of $::telegraf::download_package or $::telegraf::manage_repo can be true!')
  }

  # make sure the specific version is installed
  if $::telegraf::ensure =~ /present|installed/ {
    $ensure_version = $::telegraf::version ? {
      undef   => $::telegraf::ensure,
      default => $::telegraf::version,
    }
  } else {
    $ensure_version = $::telegraf::ensure
  }

  # fetch and install
  if (($::telegraf::download_package) and ($::telegraf::ensure =~ /present|installed|latest/)) {
    case $::osfamily {
      'debian': {
        $package_source_name = $::architecture ? {
          /armv7l/ => "telegraf_${::telegraf::version}_armhf.deb",
          default  => "telegraf_${::telegraf::version}_amd64.deb",
        }
        $package_source = "https://dl.influxdata.com/telegraf/releases/${package_source_name}"
        wget::fetch { 'telegraf':
          source      => $package_source,
          destination => "/tmp/${package_source_name}"
        }
        package { 'telegraf':
          ensure   => $::telegraf::ensure,
          provider => 'dpkg',
          source   => "/tmp/${package_source_name}",
          require  => Wget::Fetch['telegraf'],
        }
      }
      'redhat': {
        $package_source_name = $::architecture ? {
          /armv7l/ => "telegraf-${::telegraf::version}.i686.rpm",
          default  => "telegraf-${::telegraf::version}.x86_64.rpm",
        }
        $package_source = "https://dl.influxdata.com/telegraf/releases/${package_source_name}"
        exec {
          'telegraf_rpm':
            command => "rpm -ivh ${package_source}",
            path    => ['/bin', '/usr/bin'],
            unless  => 'rpm -qa | grep telegraf';

          'telegraf_from_web':
            command => "echo Installed ${package_source_name} on `date --rfc-2822` > /var/log/telegraf_from_web.log",
            path    => ['/bin', '/usr/bin'],
            require => [ Exec['telegraf_rpm'] ];
        }
      }
      default: {
        fail("Telegraf not supported on ${::osfamily} - Only Debian/Ubuntu and RedHat/Centos are supported at this time")
      }
    }
  }

  # activate InfluxData repository for package management
  if $::telegraf::manage_repo {
    $_operatingsystem = downcase($::operatingsystem)
    case $::osfamily {
      'debian': {
        apt::source { 'influxdata':
          comment  => 'Mirror for InfluxData packages',
          location => "https://repos.influxdata.com/${_operatingsystem}",
          release  => $::lsbdistcodename,
          repos    => 'stable',
          key      => {
            'id'     => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
            'source' => 'https://repos.influxdata.com/influxdb.key',
          },
        }
        ensure_packages(['apt-transport-https'])
        Class['apt::update'] -> Package['telegraf']
      }
      'redhat': {
        yumrepo { 'influxdata':
          descr    => 'influxdata',
          enabled  => 1,
          baseurl  => "https://repos.influxdata.com/rhel/${::operatingsystemmajrelease}/${::architecture}/stable",
          gpgkey   => 'https://repos.influxdata.com/influxdb.key',
          gpgcheck => true,
        }
        Yumrepo['influxdata'] -> Package['telegraf']
      }
      default: {
        fail("Telegraf not supported on ${::osfamily}- Only Debian/Ubuntu and RedHat/Centos are supported at this time")
      }
    }
    ensure_packages(['telegraf'], { ensure =>  $ensure_version })
  }

  # package management will be done differently
  else {
    # install / purge the package
    package { 'telegraf':
      ensure => $ensure_version,
    }
  }
}
