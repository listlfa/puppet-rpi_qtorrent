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


###Update Firewall

Download the updater app for ipset
```bash
mkdir --parents ~/github-ilikenwf
cd ~/github-ilikenwf/pg2ipset
git init
git clone https://github.com/ilikenwf/pg2ipset
```

Build and install the updater app
```bash
make build
sudo make install
```

Config the updater app

In file "ipset-update.sh", in folder ~/github-ilikenwf/pg2ipset, replace this
```
BLUETACKALIAS=(DShield Bogon Hijacked DROP ForumSpam WebExploit Ads Proxies BadSpiders CruzIT Zeus Palevo Malicious Malcode Adservers)
BLUETACK=(xpbqleszmajjesnzddhv lujdnbasfaaixitgmxpp usrcshglbiilevmyfhse zbdlwrqkabxbcppvrnos ficutxiwawokxlcyoeye ghlzqtqxnzctvvajwwag dgxtneitpuvgqqcpfulq xoebmbyexwuiogmbyprb mcvxsnihddgutbjfbghy czvaehmjpsnwwttrdoyl ynkdjqsjyfmilsgbogqf erqajhwrxiuvjxqrrwfj npkuuhuxcsllnhoamkvm pbqcylkejciyhmwttify zhogegszwduurnvsyhdf) 
```
with this
```
BLUETACKALIAS=(level1 level2)
BLUETACK=(ydxerpxkpcfqjaybcssw gyisgnzbhppbvsphucsw) 
```

Use the updater app to download and setup the firewall rules
```
~/github-ilikenwf/pg2ipset/ipset-update.sh
```

####Notes
- This installers the updates and sets up the firewall rules.  But there is no way to keep those rules in ipset between reboots.  You will have to save, before shutdown, and restore, after boot, yourself.  See below, in the Linux Notes, for the commands.
- Using
  - https://github.com/ilikenwf/pg2ipset
  - Lists from https://www.iblocklist.com/lists
- A manual way
  - http://dustinhatch.tumblr.com/post/33821945832/using-peerblock-lists-on-linux
  - https://www.centos.org/forums/viewtopic.php?t=8268

##Rasbian Linux Notes

###RAM
See RAM usage
```bash
free -lm
```

###'Firewall'
See lists loaded by ipset, short and long format respectively
```bash
sudo ipset list -t
sudo ipset list -t
```

Save all lists from ipset
```bash
sudo ipset save > /home/pi/ipset.conf
```

Load all lists into ipset
```bash
cat /home/pi/ipset.conf | sudo ipset restore
```


