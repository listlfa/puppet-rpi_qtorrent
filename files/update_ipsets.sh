#from http://dustinhatch.tumblr.com/post/33821945832/using-peerblock-lists-on-linux

ipset create LEVEL1 hash:net maxelem

curl -L "http://list.iblocklist.com/?list=bt_level1&fileformat=p2p&archiveformat=gz" |
    gunzip |
    cut -d: -f2 |
    grep -E "^[-0-9.]+$" |
    gawk '{print "add LEVEL1 "$1}' |
    ipset restore -exist


