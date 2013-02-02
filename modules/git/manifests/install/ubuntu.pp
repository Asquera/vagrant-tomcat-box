class git::install::ubuntu {
  if ! defined(Package['git-core']) { package { 'git-core': ensure => installed } }
}
