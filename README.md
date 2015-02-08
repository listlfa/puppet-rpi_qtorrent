# rpit_qtorrent

##Steps

###Download and install raspbian to SD card
```
http://www.raspberrypi.org/downloads/
```


###login
```
http://www.raspberrypi.org/help/quick-start-guide/
```

###setup pi, with
```bash
sudo raspi-config
```
you want to

1. Expand Filesystem (Strongly Recommended)
2. Internationalisation Options > en-au UTF (Optional)
3. Advanced Options > Hostname > rpi-qtorrent (Recommended)
4. Advanced Options > SSH > Enable (Recommended)
5. Enable Boot to Desktop/Scratch > Desktop Log in as ...  (Recommended)
6. Finish, and reboot


###update your install
```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
```


###install puppet
