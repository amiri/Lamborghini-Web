package Lamborghini::Web::Controller::Submission;

use Moose;
use namespace::autoclean;
use aliased 'Lamborghini::Forms::SubmissionForm';

BEGIN { extends 'Catalyst::Controller'; }

has 'submission_form' => (
    is => 'ro',
    isa => SubmissionForm,
    default => sub {
        SubmissionForm->new,
    }
);

sub base :Chained('/') PathPart('submit') CaptureArgs(0) {
    my ($self,$c) = @_;
}

sub index : Chained('base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;
    $c->stash(
        template => 'submission/index.tt2',
        form => $self->submission_form,
    );
}

__PACKAGE__->meta->make_immutable;

1;
