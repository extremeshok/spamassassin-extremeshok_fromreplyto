###################
# This is property of eXtremeSHOK.com
# You are free to use, modify and distribute, however you may not remove this notice.
# Copyright (c) Adrian Jon Kriel :: admin@extremeshok.com
##################
# Spam often uses a different From: and Reply-To:
# Whilst most legitimate email does not
# Sometimes the From: and Reply-To: are different, 
# but the domains will be the same.
# If the domains are different the email is sapm.
# Originially based on: scripts by Omar David Zapién López
##################

package FromIsNotReplyToWhitelist;
1;
use strict;
use Mail::SpamAssassin;
use Mail::SpamAssassin::Plugin;
our @ISA = qw(Mail::SpamAssassin::Plugin);

sub new {
	my ($class, $mailsa) = @_;
	$class = ref($class) || $class;
	my $self = $class->SUPER::new( $mailsa );
	bless ($self, $class);
	$self->register_eval_rule ( 'check_for_from_is_not_reply_to_whitelist' );
	
	return $self;
}

sub check_for_from_is_not_reply_to_whitelist {
	my ($self, $msg) = @_;
	my $from = lc($msg->get( 'From:addr' ));
	$from =~ s/.*@//;
	my $replyTo = lc($msg->get( 'Reply-To:addr' ));
	$replyTo =~ s/.*@//;

	#Mail::SpamAssassin::Plugin::dbg( "FromIsNotReplyTo: Comparing '$from'/'$replyTo" );
	if ( $from eq 'life.thinkingahead.co.za' && $replyTo eq 'sanlam.co.za' ) {
			return 1
	}
	if ( $from eq 'accounting.sageone.co.za' && $replyTo eq 'hitecsecurity.co.za' ) {
			return 1
	} 
	if ( $from eq 'post.xero.com' && $replyTo eq 'metroroofingcontractors.co.za' ) {
			return 1
	} 
	if ( $from eq 'surveys.mutualandfederal-surveys.eyerys.co.za' && $replyTo eq 'metroroofingcontractors.co.za' ) {
			return 1
	}  
	if ( $from eq 'enews.swanhellenic.com' && $replyTo eq 'pageandmoytravelgroup.com' ) {
			return 1
	}       
	if ( $from eq 'fnbstatements.co.za' && $replyTo eq 'fnb.co.za' ) {
			return 1
	}    
	if ( $from eq 'notifications.pinterest.com' && $replyTo eq 'reply.pinterest.com' ) {
			return 1
	}        
	if ( $from eq 'emc.co.za' && ($replyTo eq 'edcon.co.za' || $replyTo eq 'vodacom.co.za' || $replyTo eq 'total.co.za' ) ) {
			return 1
	} 
	if ( $replyTo eq 'mrpg.com' && ($from eq 'services.sheetstreet.com' || $from eq 'services.miladys.com' ) ) {
			return 1
	} 
	
	return 0;
}
