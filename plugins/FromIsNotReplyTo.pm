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
# Originially based on a script by Omar David Zapién López
##################

package FromIsNotReplyTo;
  use Mail::SpamAssassin::Plugin;

  our @ISA = qw(Mail::SpamAssassin::Plugin);
  sub new {
    my ($class, $mailsa) = @_;
    
    # the usual perlobj boilerplate to create a subclass object
    $class = ref($class) || $class;
    my $self = $class->SUPER::new($mailsa);
    bless ($self, $class);
   
    # then register an eval rule, if desired...
    $self->register_eval_rule ("check_for_from_is_not_reply_to");
    # and return the new plugin object
    return $self;
  }

sub check_for_from_is_not_reply_to {
  my ($self, $msg) = @_;
  my $check_from = lc($msg->get( 'From:addr' ));
  my $check_replyTo = lc($msg->get( 'Reply-To:addr' ));
  
  Mail::SpamAssassin::Plugin::dbg( "FromIsNotReplyTo: Comparing '$check_from'/'$check_replyTo" );
  
  if ( $check_from ne '' && $check_replyTo ne '' && $check_from ne $check_replyTo ) {
      return 1
  }
  return 0;
}

# This ;1 is important
1;
