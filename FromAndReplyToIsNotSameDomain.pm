###################
# This is property of eXtremeSHOK.com
# You are free to use, modify and distribute, however you may not remove this notice.
# Copyright (c) Adrian Jon Kriel :: admin@extremeshok.com
##################
# Spam often uses a different From: and Reply-To:
# Whilst most legitimate email does not
# Originially based on:scripts by Omar David Zapién López
##################

package FromAndReplyToIsNotSameDomain;
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
        $self->register_eval_rule ( 'check_for_from_and_reply_to_is_not_same_domain' );
        
        return $self;
}

sub check_for_from_and_reply_to_is_not_same_domain {
        my ($self, $msg) = @_;
        my $from = $msg->get( 'From:addr' );
        $from =~ s/.*@//;
        my $replyTo = $msg->get( 'Reply-To:addr' );
        $replyTo =~ s/.*@//;
        #Mail::SpamAssassin::Plugin::dbg( "check_for_from_and_reply_to_is_not_same_domain: Comparing '$from'/'$replyTo" );
        if ( $from ne '' && $replyTo ne '' && $from ne $replyTo ) {
                return 1;
        }

        if ( $from eq 'fnbstatements.co.za' && $replyTo eq 'fnb.co.za') {
                return 1;
        }

        if ( $from eq 'life.thinkingahead.co.za' && $replyTo eq 'sanlam.co.za') {
                return 1;
        }

        if ( $from eq 'emc.co.za' && ( $replyTo eq 'vodacom.co.za' || $replyTo eq 'total.co.za' )) {
                return 1;
        }

        return 0;
}