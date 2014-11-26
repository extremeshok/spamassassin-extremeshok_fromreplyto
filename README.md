ABOUT
================================
configure spamassassin to score mails with a reply-to header that is different from the sender (From: header).

REQUIRES
================================

spamassassin

INSTALL GUIDE
================================

wget https://raw.github.com/extremeshok/iredmail-atomic-clamav/master/update-atomic-clamav.sh -O /etc/cron.daily/update-atomic-clamav

chmod +x /etc/cron.daily/update-atomic-clamav

### edit your username and password
vi /etc/cron.daily/update-atomic-clamav
================================
 
