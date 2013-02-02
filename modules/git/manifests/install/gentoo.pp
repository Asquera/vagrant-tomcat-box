class git::install::ubuntu {
#  if ! defined(Package['git']) { package { 'git': ensure => installed } }
}
