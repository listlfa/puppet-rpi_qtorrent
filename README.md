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
```


###upgrade your install if installed from an old source
```bash
sudo apt-get update
sudo apt-get dist-upgrade

sudo reboot

sudo apt-get update
sudo apt-get upgrade
```


###install puppet
```bash
sudo apt-get install puppet
```
Note:

It will say "puppet not configured to start, please edit /etc/default/puppet to enable".  That is fine, leave this disabled.




