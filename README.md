ABOUT
================================
configure spamassassin to score mails with a reply-to header that is different from the sender (From: header).

REQUIRES
================================

spamassassin

INSTALL GUIDE
================================
# create plugin directory.
mkdir /etc/mail/spamassassin/plugins/

#download the following and save to /etc/mail/spamassassin/plugins/
FromAndReplyToIsNotSameDomain.pm
FromIsNotReplyTo.pm

# Add contents of  spamassassin_sample.conf to  /etc/mail/spamassassin/local.conf

================================
 
