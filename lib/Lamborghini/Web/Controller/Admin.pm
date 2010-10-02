package Lamborghini::Web::Controller::Admin;

use Moose;
use List::MoreUtils qw/any uniq/;

BEGIN { extends 'Catalyst::Controller'; }

sub admin_base : Chained('/') PathPart('admin') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    return $c->detach('/error_401') unless $c->user;
    my @domain_objects = map {
        ( my $label = $_ ) =~ s/^Admin:://g;
        {   label => $label,
            value => $c->uri_for( $c->controller("$_")->action_for('list') )
        }
        }
        grep {/^Admin::/} uniq sort @{ [ $c->controllers ] };
    $c->stash( domain_objects => \@domain_objects, );
}

sub index : Chained('admin_base') : PathPart('') : Args('0') {
    my ( $self, $c ) = @_;

    $c->stash( template => 'admin/index.tt2', );
}

__PACKAGE__->meta->make_immutable;

1;
