# rpi_qtorrent


##Assumptions
- Username:pi


##Steps

###Download and install raspbian to SD card
Per
- http://www.raspberrypi.org/downloads/



###login
Per
- http://www.raspberrypi.org/help/quick-start-guide/


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


###install puppet, git
```bash
sudo apt-get install puppet git
```
Note:

It will say "puppet not configured to start, please edit /etc/default/puppet to enable".  That is fine, leave this disabled.


###create ssh keys
per https://help.ubuntu.com/community/SSH/OpenSSH/Keys
```bash
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa -b 4096

ssh-copy-id pi@rpi-qtorrent
cat id_rsa.pub >> authorized_keys
```
Notes
- Save files to default location
- 'Passphrase' is a password
- No passphrase means quick login via putty
- import via puttygen and export as ppk files.  putty needs the private key.


###config git repo and pull files
```bash
mkdir --parents ~/github-listlfa
cd ~/github-listlfa
git init
git clone https://github.com/listlfa/rpi_qtorrent
```


###apply puppet config
```bash
sudo puppet apply setup.pp
```


###Get the pg2 updater, for ipset.  this should be more efficient than a noraml import from the bluetack .gz files
From https://github.com/ilikenwf/pg2ipset

EG manual way
- http://dustinhatch.tumblr.com/post/33821945832/using-peerblock-lists-on-linux
- https://www.centos.org/forums/viewtopic.php?t=8268

```bash
mkdir --parents ~/github-ilikenwf
cd ~/github-ilikenwf
git init
git clone https://github.com/ilikenwf/pg2ipset
```


