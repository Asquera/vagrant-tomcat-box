class tomcat7 {
  include tomcat7::jpackage_repo
  
  package { "tomcat7":
    ensure => installed,
    require => [Yumrepo['jpackage']]
  }

  service { "tomcat7":
    ensure => started,
    require => [Package['tomcat7']]
  }
}
