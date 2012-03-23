define monit::service($source_file) {
  if $source_file {
    file { "/etc/monit/conf.d/${name}":
      owner => root,
      group => root,
      mode => 0644,
      source => $source_file,
      notify => Service["monit"],
      require => Package["monit"],
  } else {
    file { "/etc/monit/conf.d/${name}":
      owner => root,
      group => root,
      mode => 0644,
      content => template("monit/service.erb"),
      notify => Service["monit"],
      require => Package["monit"],
    }
  }
}
