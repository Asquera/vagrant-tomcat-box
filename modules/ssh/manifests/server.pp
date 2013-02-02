
class ssh::server {
    
  file { "/etc/ssh/sshd_config":
    content => template("ssh/server/sshd_config.erb"),
    ensure => present,
    notify => Service['sshd']
  }
	
  service { "sshd":
	  require => Package['openssh-server'],
    ensure => running,
    enable => true
  }

  package { "openssh-server":
    ensure => present
  }

}
