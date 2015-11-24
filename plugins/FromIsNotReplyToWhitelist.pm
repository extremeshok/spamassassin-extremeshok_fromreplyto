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
	my $check_from = lc($msg->get( 'From:addr' ));
	$check_from =~ s/.*@//;
	my $check_replyTo = lc($msg->get( 'Reply-To:addr' ));
	$check_replyTo =~ s/.*@//;

	#Mail::SpamAssassin::Plugin::dbg( "FromIsNotReplyTo: Comparing '$check_from'/'$check_replyTo" );
	if ( $check_from eq 'life.thinkingahead.co.za' && $check_replyTo eq 'sanlam.co.za' ) {
			return 1
	}
	if ( $check_from eq 'accounting.sageone.co.za' && $check_replyTo eq 'hitecsecurity.co.za' ) {
			return 1
	} 
	if ( $check_from eq 'post.xero.com' && $check_replyTo eq 'metroroofingcontractors.co.za' ) {
			return 1
	} 
	if ( $check_from eq 'surveys.mutualandfederal-surveys.eyerys.co.za' && $check_replyTo eq 'metroroofingcontractors.co.za' ) {
			return 1
	}  
	if ( $check_from eq 'enews.swanhellenic.com' && $check_replyTo eq 'pageandmoytravelgroup.com' ) {
			return 1
	}       
	if ( $check_from eq 'fnbstatements.co.za' && $check_replyTo eq 'fnb.co.za' ) {
			return 1
	}
	if ( $check_from eq 'msccruises.co.za' && $check_replyTo eq 'msccruises.com' ) {
			return 1
	}    
	if ( $check_from eq 'notifications.pinterest.com' && $check_replyTo eq 'reply.pinterest.com' ) {
			return 1
	}    
	if ( $check_from eq 'mrpmoney.mrp.com' && $check_replyTo eq 'mrpricegroup.com' ) {
			return 1
	}        
	if ( $check_from eq 'emc.co.za' && ($check_replyTo eq 'edcon.co.za' || $check_replyTo eq 'vodacom.co.za' || $check_replyTo eq 'total.co.za' ) ) {
			return 1
	} 
	if ( $check_replyTo eq 'mrpg.com' && ($check_from eq 'services.sheetstreet.com' || $check_from eq 'services.miladys.com' ) ) {
			return 1
	} 
	
	return 0;
}
