class monit ($mailserver = 'localhost', $alert_email = undef, $alert_scope = undef){

	file { "/etc/default/monit":
		owner   => root,
		group   => root,
		mode    => 0644,
		alias   => "monit",
		source  => "puppet:///modules/monit/${::operatingsystem}/default",
		notify  => Service["monit"],
		require => Package["monit"],
	}

	file { "/etc/monit/conf.d":
		force   => true,
		purge   => true,
		recurse => true,
		owner   => root,
		group   => root,
		mode    => 0644,
		require => Package["monit"],
	}

	file { "/etc/monit/monitrc":
		owner   => root,
		group   => root,
		mode    => 0600,
		alias   => "monitrc",
		content => template("monit/${::operatingsystem}/monitrc.erb"),
		notify  => Service["monit"],
		require => Package["monit"],
	}

	package { "monit":
		ensure => present,
	}

	service { "monit":
		enable     => true,
		ensure     => running,
		hasrestart => true,
		hasstatus  => false,
		require    => [
			File["monit"],
			File["monitrc"],
			Package["monit"]
		],
	}
}

