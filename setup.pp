## Setup qtorrent RPI

class qtorrent {

	#	-	-	-	-
	# Standard Packages to Ensure Installed
	#	-	-	-	-
	package { "openssh-server":
		ensure	=> latest,
	}



	#	-	-	-	-
	# Non-Standard Packages to Install
	#	-	-	-	-
	$package_samba = [ "samba", "samba-common-bin" ]  # http://theurbanpenguin.com/wp/?p=2415
	
	package { "tightvncserver":
		ensure	=> latest,
	}
	#package { "qbittorrent":
	#	ensure	=> latest,
	#}
	package { "ipset":
		ensure	=> latest,
	}
	package { "gawk":		#for ipset scripts
		ensure	=> latest,
	}
	package { "transmission-cli":	#per http://www.webupd8.org/2009/12/setting-up-transmission-remote-gui-in.html
		ensure	=> latest,
	}
	package { "transmission-common":
		ensure	=> latest,
	}
	package { "transmission-daemon":
		ensure	=> latest,
	}
	package { "p7zip":
		ensure	=> latest,
	}
	package { $package_samba:
		ensure	=> latest,
	}
	
	



	#	-	-	-	-
	# Packages to Remove (# remove a package and purge its config files)
	#	-	-	-	-
	#Video Player
	package { "omxplayer":
		ensure	=> purged,
	}
	#Maths App
	package { "wolfram-engine":
		ensure	=> purged,
	}
	#Music App
	package { "sonic-pi":
		ensure	=> purged,
	}
	#Game
	package { "minecraft-pi":
		ensure	=> purged,
	}
	#Programming IDE
	package { "scratch":
		ensure	=> purged,
	}
	#Programming Unkown
	package { "squeak-vm":
		ensure	=> purged,
	}
	package { "squeak-plugins-scratch":
		ensure	=> purged,
	}



	#START SYSTEM HARDENING
	service { "ssh":
		ensure  => "running",
		enable  => "true",
		require => Package["openssh-server"],
	}

	file { '/etc/ssh/sshd_config':
		notify  => Service["ssh"],  # this sets up the relationship.  Doesn't do the restart :(
		ensure	=> file,
		owner	=> root,
		group	=> root,
		mode	=> 644,
		source	=> '/home/pi/github-listlfa/rpi_qtorrent/files/etc--ssh--sshd_config',
	}
	#END SYSTEM HARDENING



	#START VNC
	# copied from
	# http://elinux.org/RPi_VNC_Server#Run_at_boot
	#
	# Not starting VNC, when running headless, saves about 190MB RAM
	
	$vncfiles = [	'/etc/init.d/vncboot',
			'/etc/rc2.d/S02vncboot',
				]
	file { $vncfiles:
		ensure	=> absent,
	}
	
	#file { '/etc/init.d/vncboot':
	#	ensure	=> present,
	#	mode	=> 755,
	#	source	=> '/home/pi/github-listlfa/rpi_qtorrent/files/vncserver',
	#	require	=> Package['tightvncserver'],
	#}

	#exec { 'vnc--init.d':
	#	command => 'sudo update-rc.d vncboot defaults',
	#	path	=> [ "/usr/sbin/", "/usr/bin", "/sbin/", "/bin/" ],# alternative syntax
	#	require	=> File['/etc/init.d/vncboot'],
	#}
	#->
	#exec { 'vnc--password':
	#	#command => 'sudo update-rc.d /etc/init.d/vncboot defaults',
	#	command => 'sudo update-rc.d vncboot defaults',
	#	path	=> [ "/usr/sbin/", "/usr/bin", "/sbin/", "/bin/" ],# alternative syntax
	#}

	#file { '/home/pi/.vnc':
	#	ensure	=> directory,
	#	mode	=> 776,
	#}
	#END VNC



	#START TRANSMISSION
	#from http://www.techjawab.com/2014/08/how-to-install-transmission-on.html
	
	#https://help.ubuntu.com/community/TransmissionHowTo#Configure
	file { '/var/lib/transmission-daemon/info/settings.json':
		ensure	=> file,
		owner	=> debian-transmission,
		group	=> debian-transmission,
		mode	=> 600,
		source	=> '/home/pi/github-listlfa/rpi_qtorrent/files/var--lib--transmission-daemon--info--settings.json',
	}
	#END TRANMISSION



	#START USER SCRIPT FILES
	file { '/home/pi/userscripts/':
		ensure	=> directory,
		owner	=> pi,
		group	=> pi,
	}
	file { '/home/pi/userscripts/create_ipsets.sh':
		ensure	=> file,
		owner	=> pi,
		group	=> pi,
		mode	=> 776,
		source	=> '/home/pi/github-listlfa/rpi_qtorrent/files/create_ipsets.sh',
		require	=> File['/home/pi/userscripts/'],
	}
	#END USER SCRIPT FILES



	#START SHARE FOLDER
	file { '/home/pi/share/':
		ensure	=> directory,
		owner	=> pi,
		group	=> pi,
		mode	=> 1777,
	}
	#END SHARE FOLDER
	
	
	
}



include qtorrent

