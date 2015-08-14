# spamassassin-from_is_not_reply-to
Spamassassin from is not reply-to

## Maintained and provided by https://eXtremeSHOK.com

## Description
configure spamassassin to score mails with a reply-to header that is different from the sender (From: header).


## REQUIRES
spamassassin

## INSTALL GUIDE

create the plugin directory.

mkdir /etc/mail/spamassassin/plugins/

download the following and save to /etc/mail/spamassassin/plugins/

FromAndReplyToIsNotSameDomain.pm
FromIsNotReplyTo.pm
FromIsNotReplyToWhitelist.pm

Download and save 01_extremeshok_fromreplyto.cf to  /etc/mail/spamassassin/01_extremeshok_fromreplyto.cf
 
