## Setup qtorrent RPI

class qtorrent {
	#	-	-	-	-
	# Packages to Install
	#	-	-	-	-
	package { "tightvncserver":
		ensure  => latest,
	}
	package { "qbittorrent":
		ensure  => latest,
	}
	package { "ipset":
		ensure  => latest,
	}
	#	-	-	-	-
	# Packages to Remove (# remove a package and purge its config files)
	#	-	-	-	-
	#Video Player
	package { "omxplayer":
		ensure  => purged,
	}
	#Maths App
	package { "wolfram-engine":
		ensure  => purged,
	}
	#Music App
	package { "sonic-pi":
		ensure  => purged,
	}
	#Game
	package { "minecraft-pi":
		ensure  => purged,
	}
	#Programming IDE
	package { "scratch":
		ensure  => purged,
	}
	#Programming Unkown
	package { "squeak-vm":
		ensure  => purged,
	}
	package { "squeak-plugins-scratch":
		ensure  => purged,
	}
	
	#START VNC
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
		mode   => 776,
	}
	#END VNC
	
	#START USER SCRIPT FILES
	file { '/home/pi/userscripts/':
		ensure => directory,
		owner  => pi,
		group  => pi,
	}
	file { '/home/pi/userscripts/create_ipsets.sh':
		ensure => file,
		owner  => pi,
		group  => pi,
		mode   => 776,
		source => '/home/pi/github-listlfa/rpi_qtorrent/files/create_ipsets.sh',
		Require=>File['/home/pi/userscripts/']
	}
	#END USER SCRIPT FILES
    }
    
    
}

include qtorrent

