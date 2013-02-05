# installs the jdk from an rpm
# you need to drop the rpm into the files folder

class java::jdk {
  
  $jdk = "jdk.x86_64" 
  
  # fetch the jdk tarball.
  file { "/root/$jdk.rpm":
    source => "puppet:///modules/java/rpms/jdk-7u13-linux-x64.rpm", # fetch from the puppet server.
  } 
 
  file { "/root/select-java.sh":
     source => "puppet:///modules/java/select-java.sh",
     mode   => 0700,
  }
 
  package {"$jdk":
    source  => "/root/$jdk.rpm",
    ensure  => installed,
    require => File["/root/$jdk.rpm"], 
    provider => "rpm", # the yum provider can't install from file.
  }

  exec {"/root/select-java.sh":
    require => [Package["$jdk"], File["/root/select-java.sh"]]
  }
    
}
