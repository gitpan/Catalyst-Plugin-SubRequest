package Catalyst::Plugin::SubRequest;

use strict;

our $VERSION = '0.02';


=head1 NAME

Catalyst::Plugin::SubRequest - Make subrequests to actions in Catalyst

=head1 SYNOPSIS

    use Catalyst 'SubRequest';

    $c->forward_request('!test','foo','bar');

=head1 DESCRIPTION

Make subrequests to actions in Catalyst.

=head2 METHODS

=head3 forward_request

takes the name of the action you would like to call, as well as the
arguments you want to pass to it.

=cut
*subreq=\&sub_request;
sub sub_request {
    my ( $c, $action, @args ) = @_;
    my $stash = $c->{stash} ; $c->{stash}= {};
    my $content = $c->res->output; $c->res->output(undef);
    my $args = $c->req->arguments; $c->req->arguments([@args]);
    $c->forward($action);
    $c->forward('!end');
    my $output=$c->res->output;
    $c->{stash}=$stash;
    $c->res->output($content);
    $c->req->arguments($args);
    return $output;
}

=head1 SEE ALSO

L<Catalyst>.

=head1 AUTHOR

Marcus Ramberg, C<mramberg@cpan.org>

=head1 THANK YOU

SRI, for writing the awesome Catalyst framework

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
