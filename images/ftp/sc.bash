lftp -d <<SCRIPT
source lftp.ssl.commands
dir
SCRIPT
# su-exec one lftp -u one,1234 localhost:21 -e 'ls; exit;'

# lftp -u one,1234 45.138.25.104:21 -e 'set ssl:verify-certificate off;'

