## Setup qtorrent RPI

class qtorrent {
	package { "tightvncserver":
		ensure  => latest,
	}
	
	# copied from
	# http://elinux.org/RPi_VNC_Server#Run_at_boot
	file { '/etc/init.d/vncboot':
		ensure => file,
		mode   => 755,
		source => '/home/pi/github-listlfa/rpi_qtorrent/files/vncserver',
    }
    ->
    exec { 'init.d--vncboot':
      command => 'sudo update-rc.d /etc/init.d/vncboot defaults',
      path    => [ "/usr/sbin/", "/usr/bin", "/bin/" ],  # alternative syntax
    }
}

include qtorrent

