class tomcat7::jpackage_repo {
  yumrepo { "jpackage-6.0-generic":
    descr => "JPackage project",
    mirrorlist => "http://www.jpackage.org/mirrorlist.php?dist=generic&type=free&release=6.0",
    enabled => 1,
    gpgcheck => 1,
    gpgkey => "http://www.jpackage.org/jpackage.asc",
  }
}
