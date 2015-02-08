## Setup qtorrent RPI

class qtorrent {
	package { "tightvncserver":
		ensure  => latest,
	}

}

include qtorrent

