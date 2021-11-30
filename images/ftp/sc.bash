lftp -d <<eof
source lftp.ssl.commands
dir
eof
# su-exec one lftp -u one,1234 localhost:21 -e 'ls; exit;'
