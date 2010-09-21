package Lamborghini::Web::Controller::Gallery;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    my $images = [ $c->model('DB::Picture')->all ];
    $c->stash( template => 'gallery.tt2', images => $images, );
}

__PACKAGE__->meta->make_immutable;

1;
