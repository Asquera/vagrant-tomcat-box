class doinstall {

  package {"vim-enhanced":
    ensure => installed
  }

  include installrvm
  include java::jdk
  include tomcat7
  include oracle-xe
  include redis::server

  class { requirements: stage => 'requirementsstage' }
 
}

node default {
   include base
}

class base {
   yumrepo { "remi":
      baseurl => "http://rpms.famillecollet.com/enterprise/$operatingsystemrelease/remi/$architecture/",
      descr => "Les RPM de remi pour Fedora $operatingsystemrelease - $architecture",
      enabled => 1,
      gpgcheck => 1,
      gpgkey => "http://rpms.famillecollet.com/RPM-GPG-KEY-remi"
   }
   yumrepo { "EPEL":
     baseurl => "http://dl.fedoraproject.org/pub/epel/6/$architecture/",
     descr => "The EPEL repository",
     enabled => "1",
     gpgcheck => "0"
   }
}

class requirements {
  include sysconfig
  include sysconfig::sudoers
  include ssh::server

  group { "vagrant":
    ensure => 'present',
  }
  user { "vagrant":
    ensure  => 'present',
    gid     => 'vagrant',
    require => Group['vagrant']
  } -> file { "/home/vagrant":
    ensure => directory,
    owner  => vagrant
  }

  ssh::user { "vagrant": }

  # user and group puppet necessary for rvm
  group { "puppet":
    ensure => 'present',
  }
  user { "puppet":
    ensure  => 'present',
    gid     => 'puppet',
    require => Group['puppet']
  }
}

class installrvm {
  include rvm

  # ruby version to use
  $rubyversion = 'jruby'

  Exec {
    path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/", "/usr/local/rvm/bin" ]
  }

  rvm::system_user { vagrant: ; }

  rvm_system_ruby { $rubyversion:
    ensure => 'present',
    default_use => true,
  }
}

Class['java::jdk'] -> Class['installrvm'] 

stage { 'requirementsstage': before => Stage['main'] }
  
  # disable the firewall
  service {"iptables":
    ensure => stopped
  }
  
  service {"ip6tables":
    ensure => stopped
  }
# start and set up everything
include doinstall
