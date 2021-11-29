#!/bin/bash
lftp <<SCRIPT
open ftps://localhost:8083
user ftp alpineftp
cd /
SCRIPT

#set ftp:ssl-force true
#set ftp:ssl-protect-data true
# set ftps:initial-prot ""
# lcd /tmp
#put foo.txt
#exit
