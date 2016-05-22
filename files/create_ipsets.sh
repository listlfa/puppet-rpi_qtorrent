#from http://dustinhatch.tumblr.com/post/33821945832/using-peerblock-lists-on-linux
#https://www.centos.org/forums/viewtopic.php?t=8268

# manual == sudo ipset create LEVEL1 hash:net maxelem 1048576
ipset create LEVEL1 hash:net maxelem 1048576 

# manual == curl -L "http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz" | gunzip | cut -d: -f2 | grep -E "^[-0-9.]+$" | gawk '{print "add LEVEL1 "$1}' | ipset restore -exist
curl -L "http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz" |
    gunzip |
    cut -d: -f2 |
    grep -E "^[-0-9.]+$" |
    gawk '{print "add LEVEL1 "$1}' |
    ipset restore -exist


