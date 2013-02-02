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
    default_use => true;
  }
}

class projects {
  # set permissions on dev directory where all projects reside
  file { "/home/vagrant/dev":
    ensure => 'directory',
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => 750
  }
}

stage { 'requirementsstage': before => Stage['main'] }

class doinstall {

  package {"vim-enhanced":
    ensure => installed
  }

  include projects
  include installrvm
  include java::jdk
  include tomcat7

  class { requirements: stage => 'requirementsstage' }

  Class['java::jdk'] -> Class['tomcat7'] -> Class['installrvm'] -> Class['projects']
}

# start and set up everything
include doinstall


