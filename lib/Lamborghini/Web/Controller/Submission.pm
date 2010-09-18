package Lamborghini::Web::Controller::Submission;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body(
        'Matched Lamborghini::Web::Controller::Submission in Submission.');
}

__PACKAGE__->meta->make_immutable;

1;
