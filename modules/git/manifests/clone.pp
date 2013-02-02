define git::clone(
  $repository_name = '',
  $repository_url,
  $cwd = './',
  $user,
  $group
) {
  require git

  Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

  if $repository_name == '' {
    $repo_name = $name
  } else {
    $repo_name = $repository_name
  }

  $command = "git clone --recursive --quiet ${repository_url} ${repo_name}"

  exec { "git-clone-${repository_url}":
    command => $command,
    cwd => $cwd,
    user => $user,
    group => $group,
  }
}