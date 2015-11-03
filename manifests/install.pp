# == Class: telegraf::install
# DO NO CALL DIRECTLY
class telegraf::install {
  $package_ensure = $::ensure
  case $package_ensure {
    true:     {
      $my_package_ensure = 'present'
    }
    false:    {
      $my_package_ensure = 'absent'
    }
    'absent': {
      $my_package_ensure = 'absent'
    }
    'purged': {
      $my_package_ensure = 'purged'
    }
    default:  {
      $my_package_ensure = $package_ensure
    }
  }

  if ((!$telegraf::install_from_repository) and ($my_package_ensure =~ /present|installed/ )) {
    # package source and provider
    case $::osfamily {
      'Debian': {
        $package_source_name = $::architecture ? {
          /386/   => "telegraf_${telegraf::version}_i386.deb",
          default => "telegraf_${telegraf::version}_amd64.deb",
        }
        $package_source = "http://get.influxdb.org/telegraf/${package_source_name}"
        wget::fetch { 'telegraf':
          source      => $package_source,
          destination => "/tmp/${package_source_name}"
        }
        package { 'telegraf':
          ensure   => $my_package_ensure,
          provider => 'dpkg',
          source   => "/tmp/${package_source_name}",
          require  => Wget::Fetch['telegraf'],
        }
      }
      'RedHat', 'Amazon': {
        $package_source_name = $::architecture ? {
          /386/   => "telegraf-${telegraf::version}-1.i686.rpm",
          default => "telegraf-${telegraf::version}-1.x86_64.rpm",
        }
        $package_source = "http://get.influxdb.org/telegraf/${package_source_name}"
        exec {
          'telegraf_rpm':
            command => "rpm -ivh ${package_source}",
            path    => ['/bin', '/usr/bin'],
            unless  => 'rpm -qa | grep telegraf';

          'telegraf_from_web':
            command => "echo Installed ${package_source_name} on `date --rfc-2822` > /opt/telegraf/versions/telegraf_from_web",
            path    => ['/bin', '/usr/bin'],
            require => [ Exec['telegraf_rpm'] ];
        }
      }
      default: {
        fail('Only supports Debian / Ubuntu or RedHat $::osfamily')
      }
    }
  }
  else {
    # install / purge the package
    package { 'telegraf':
      ensure => $my_package_ensure,
    }
  }
}
