# installs the redis-server from an rpm

class redis::server {

  if ! defined(Package['gperftools-libs']) {
    package { 'gperftools-libs':
      ensure => installed,
      require => Yumrepo["EPEL"]
    }
  }

  package { 'redis':
    ensure => '2.6.9-1.el6.remi',
    require => [Yumrepo["remi"], Package['gperftools-libs']],
    notify => Service['redis']
  } -> service { 'redis':
    ensure => running
  }

}
