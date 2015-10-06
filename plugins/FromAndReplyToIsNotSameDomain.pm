###################
# This is property of eXtremeSHOK.com
# You are free to use, modify and distribute, however you may not remove this notice.
# Copyright (c) Adrian Jon Kriel :: admin@extremeshok.com
##################
# Spam often uses a different From: and Reply-To:
# Whilst most legitimate email does not
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
	my $from = lc($msg->get( 'From:addr' ));
	$from =~ s/.*@//;

	my $replyTo = lc($msg->get( 'Reply-To:addr' ));
	$replyTo =~ s/.*@//;

	if(( $from eq '' ) || ( $replyTo eq '' )){
			return 0; #PASS, empty from or reply to
	}
	#short-circuit logic
	if( $from ne $replyTo )  {
			#create arrays to make life easier
			my @fromParts = split( /\./, $from );
			my @replyToParts = split( /\./, $replyTo );


			if (( $#fromParts ge 2) && ( $#fromParts ge 2 )) { 
					if ($fromParts[-1] ne $replyToParts[-1]){ 
							return 1; #fail, not the same .tld
					}
					if ($fromParts[-2] ne $replyToParts[-2]){ 
							return 1; #fail, not the same domain.tld / tld.tld
					}
			}
			if (( $#fromParts ge 3) && ( $#fromParts ge 3 )) {
					if ($fromParts[-3] ne $replyToParts[-3]){ 
							return 1; #fail,not the same sub.domain.tld / domain.tld.tld
					}
			}
			if (( $#fromParts ge 4) && ( $#fromParts ge 4 )) {
					if (( $#fromParts gt 4) || ( $#fromParts gt 4 )) {                     
							if ($fromParts[-4] ne $replyToParts[-4]){ 
									return 1; #fail,not the same domain sub.sub.sub.domain.tld / sub.sub.domain.tld.tld
							}
					}else{
							if ($fromParts[-3] ne $replyToParts[-3]){ 
									return 1; #fail,not the same domain sub.sub.domain.tld / sub.domain.tld.tld
							}     
					}
			}
	}

	return 0; #PASS
}
