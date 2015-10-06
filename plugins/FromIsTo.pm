###################
# This is property of eXtremeSHOK.com
# You are free to use, modify and distribute, however you may not remove this notice.
# Copyright (c) Adrian Jon Kriel :: admin@extremeshok.com
##################
# Spam often uses the same From: and To:
# Whilst most legitimate email does not
# If the domains are different the email is sapm.
##################

package FromIsNotTo;
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
	$self->register_eval_rule ( 'check_for_from_is_to' );
	
	return $self;
}

sub check_for_from_is_to {
	my ($self, $msg) = @_;
	my $from = lc($msg->get( 'From:addr' ));
	my $replyTo = lc($msg->get( 'To:addr' ));
	#Mail::SpamAssassin::Plugin::dbg( "FromIsTo: Comparing '$from'/'$to" );
	if ( $from ne '' && $to ne '' && $from eq $to ) {
			return 1
	}
	return 0;
}