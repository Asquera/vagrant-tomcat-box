class git::install {
  case $::operatingsystem {
    Ubuntu,Debian: { require git::install::ubuntu }
    Gentoo: { require git::install::gentoo }
  }
}