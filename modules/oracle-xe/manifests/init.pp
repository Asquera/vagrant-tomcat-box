class oracle-xe {
    # bc is used by oracle-xe. it is not a direct dependency, but without it, the configure step
    # fails
    # see
    # http://www.pythian.com/news/30197/installing-oracle-vm-manager-3-0-3-under-dom0-host-or-how-to-save-resources-on-your-sandbox/

    package { 'bc':
      ensure => installed 
    }

    package { 'libaio':
      ensure => installed 
    }

    package { "ntp": 
      ensure => installed
    }
    
    file { "/etc/sysconfig/ntpd":
        mode    => "644",
        source => "puppet:///modules/oracle-xe/sysconfig-ntpd.client",
        notify  => Service["ntpd"],
        require => Package["ntp"],
    }
    
    file { "/etc/ntp.conf":
        mode    => "644",
        source => "puppet:///modules/oracle-xe/ntp.conf.client",
        notify  => Service["ntpd"],
        require => Package["ntp"],
    }

    service { "ntpd":
      ensure  => running,
      enable  => true,
      require => Package["ntp"],
    } 

    file {"/etc/localtime":
      ensure => link,
      target => "/usr/share/zoneinfo/Europe/Berlin"
    }

    # installs the oracle xe from an rpm
    # you need to drop the rpm into the files folder

  
    $orapkg = "oracle-xe-11.2.0-1.0" 
  
    # fetch the rpm.
    file { "/root/$orapkg.rpm":
      source => "puppet:///modules/oracle-xe/rpms/oracle-xe-11.2.0-1.0.x86_64.rpm", # fetch from the puppet server.
    } 
  
    package {"$orapkg":
      source  => "/root/$orapkg.rpm",
      ensure  => installed,
      require => [File["/root/$orapkg.rpm"], Package['bc'], Package["libaio"]],
      provider => "rpm", # the yum provider can't install from file.
    }

    file {"/root/xe.rsp":
      source => "puppet:///modules/oracle-xe/xe.rsp"
    }

    exec { 'configure-xe':
      command => "/etc/init.d/oracle-xe configure responseFile=/root/xe.rsp >> /root/xe-install.log",
      require => [Package["$orapkg"], File["/root/xe.rsp"]],
      user => root,
      creates => "/root/xe-install.log",
    }

    file {"/root/grants.sql":
      source => "puppet:///modules/oracle-xe/grants.sql"
    }

    exec { 'add-users':
      command => "/u01/app/oracle/product/11.2.0/xe/bin/sqlplus system/manager@//localhost:1521/xe @/root/grants.sql",
      environment => "ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe/",
      require => [File["/root/grants.sql"], Exec['configure-xe']]
    } 
}
