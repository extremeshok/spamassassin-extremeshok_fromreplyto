###################
# This is property of eXtremeSHOK.com
# You are free to use, modify and distribute, however you may not remove this notice.
# Copyright (c) Adrian Jon Kriel :: admin@extremeshok.com
##################
# Spam and Ham can use the same domain for the From: and To: with different email addresses.
# You will need to enable addition processing (whitelist authorized users and/or whitelist allowed sending servers) to prevent this from blocking legitimate same domain emailing.
##################

package FromAndToIsSameDomain;
  use Mail::SpamAssassin::Plugin;

  our @ISA = qw(Mail::SpamAssassin::Plugin);
  sub new {
    my ($class, $mailsa) = @_;

    # the usual perlobj boilerplate to create a subclass object
    $class = ref($class) || $class;
    my $self = $class->SUPER::new($mailsa);
    bless ($self, $class);

    # then register an eval rule, if desired...
    $self->register_eval_rule ("check_for_from_and_to_is_same_domain");
    # and return the new plugin object
    return $self;
  }

sub check_for_from_and_to_is_same_domain {
  my ($self, $msg) = @_;
  my $check_from = lc($msg->get( 'From:addr' ));
  $check_from =~ s/.*@//;

  my $check_to = lc($msg->get( 'To:addr' ));
  $check_to =~ s/.*@//;

  Mail::SpamAssassin::Plugin::dbg( "FromAndToIsSameDomain: Comparing '$check_from'/'$check_to" );

  if(( $check_from eq '' ) || ( $check_to eq '' )){
      return 0; #PASS, empty from or reply to
  }

  my (@check_fromParts, @check_toParts);

  #short-circuit logic
  if( $check_from ne $check_to )  {
      #create arrays to make life easier
      @check_fromParts = split( /\./, $check_from );
      @check_toParts = split( /\./, $check_to );


      if (( $#check_fromParts ge 2) && ( $#check_fromParts ge 2 )) {
          if ($check_fromParts[-1] ne $check_toParts[-1]){
              return 1; #fail, not the same .tld
          }
          if ($check_fromParts[-2] ne $check_toParts[-2]){
              return 1; #fail, not the same domain.tld / tld.tld
          }
      }
      if (( $#check_fromParts ge 3) && ( $#check_fromParts ge 3 )) {
          if ($check_fromParts[-3] ne $check_toParts[-3]){
              return 1; #fail,not the same sub.domain.tld / domain.tld.tld
          }
      }
      if (( $#check_fromParts ge 4) && ( $#check_fromParts ge 4 )) {
          if (( $#check_fromParts gt 4) || ( $#check_fromParts gt 4 )) {
              if ($check_fromParts[-4] ne $check_toParts[-4]){
                  return 1; #fail,not the same domain sub.sub.sub.domain.tld / sub.sub.domain.tld.tld
              }
          }else{
              if ($check_fromParts[-3] ne $check_toParts[-3]){
                  return 1; #fail,not the same domain sub.sub.domain.tld / sub.domain.tld.tld
              }
          }
      }
  }
  return 0; #PASS
}

# This ;1 is important
1;
