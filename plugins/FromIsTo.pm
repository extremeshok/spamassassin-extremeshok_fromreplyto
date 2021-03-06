###################
# This is property of eXtremeSHOK.com
# You are free to use, modify and distribute, however you may not remove this notice.
# Copyright (c) Adrian Jon Kriel :: admin@extremeshok.com
##################
# Spam often uses the same From: and To:
# Whilst most legitimate email does not
# If the domains are different the email is sapm.
##################

package FromIsTo;
use Mail::SpamAssassin::Plugin;

our @ISA = qw(Mail::SpamAssassin::Plugin);

sub new {
    my ( $class, $mailsa ) = @_;

    # the usual perlobj boilerplate to create a subclass object
    $class = ref($class) || $class;
    my $self = $class->SUPER::new($mailsa);
    bless( $self, $class );

    # then register an eval rule, if desired...
    $self->register_eval_rule("check_for_from_is_to");

    # and return the new plugin object
    return $self;
}

sub check_for_from_is_to {
    my ( $self, $msg ) = @_;
    my $check_from = lc( $msg->get('From:addr') );
    my $check_to   = lc( $msg->get('To:addr') );

    Mail::SpamAssassin::Plugin::dbg(
        "FromIsTo: Comparing '$check_from'/'$check_to");

    if ( $check_from ne '' && $check_to ne '' && $check_from eq $check_to ) {
        return 1;
    }
    return 0;
}

# This ;1 is important
1;
