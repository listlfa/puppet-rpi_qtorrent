## Setup qtorrent RPI

class qtorrent {
	package { "tightvncserver":
		ensure  => latest,
	}
	package { "qbittorrent":
		ensure  => latest,
	}
	

	# copied from
	# http://elinux.org/RPi_VNC_Server#Run_at_boot
	file { '/etc/init.d/vncboot':
		ensure => file,
		mode   => 755,
		source => '/home/pi/github-listlfa/rpi_qtorrent/files/vncserver',
		require => Package['tightvncserver'],
	}

	exec { 'vnc--init.d':
		#command => 'sudo update-rc.d /etc/init.d/vncboot defaults',
		command => 'sudo update-rc.d vncboot defaults',
		path    => [ "/usr/sbin/", "/usr/bin", "/sbin/", "/bin/" ],  # alternative syntax
		require => File['/etc/init.d/vncboot'],
	}
	->
	exec { 'vnc--password':
		#command => 'sudo update-rc.d /etc/init.d/vncboot defaults',
		command => 'sudo update-rc.d vncboot defaults',
		path    => [ "/usr/sbin/", "/usr/bin", "/sbin/", "/bin/" ],  # alternative syntax
	}

	file { '/home/pi/.vnc':
		ensure => directory,
		mode   => 755,
    }
    
    
}

include qtorrent

