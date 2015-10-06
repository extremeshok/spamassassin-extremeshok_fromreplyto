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
FromIsTo.pm

Download and save 01_extremeshok_fromreplyto.cf to  /etc/mail/spamassassin/01_extremeshok_fromreplyto.cf

 
## Version 1.3 (updated 2015-10-06)
 - eXtremeSHOK.com Maintenance
 - Added FromIsTo, most spam emails the from" and to" is identical
 - Minor code cleanups
 
## Version 1.2.10 (updated 2015-08-16)
 - eXtremeSHOK.com Maintenance
 - Fix for scoring missing from/replyto as a fail

## Version 1.2.0 (updated 2015-08-16)
 - eXtremeSHOK.com Maintenance
 - Better logic with domain checking, will allow for different subdomains of the same domain name.
