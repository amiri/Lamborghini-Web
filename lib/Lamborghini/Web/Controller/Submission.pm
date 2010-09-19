package Lamborghini::Web::Controller::Submission;

use Moose;
use Devel::Dwarn;
use namespace::autoclean;
use aliased 'Lamborghini::Forms::SubmissionForm';

BEGIN { extends 'Catalyst::Controller'; }

has 'submission_form' => (
    is      => 'ro',
    isa     => SubmissionForm,
    default => sub {
        SubmissionForm->new,;
    }
);

sub base : Chained('/') PathPart('submit') CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub index : Chained('base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;
    my $form = $self->submission_form;
    my $new_user = $c->model('DB::User')->new_result( {} );
    $c->stash(
        template => 'submission/index.tt2',
        form     => $form,
    );
    if ( lc $c->req->method eq 'post' ) {
        $c->req->params->{'file'} = $c->req->upload('file');
    }
    $form->process(
        ctx    => $c,
        item   => $new_user,
        params => $c->req->params,
    );
    $c->log->debug( "Errors: " . Dwarn $form->errors );
    $c->stash( fillinform => $form->fif, );
    return unless $form->validated;
    my $new_picture = $c->model('DB::Picture')->create(
        {   user        => $new_user->id,
            file        => $form->field('file')->value->filename,
            description => $new_user->email,
        }
    );
    $c->flash( status_msg => "Thank you for submitting your information." );
    $c->res->redirect( $c->uri_for('/') );
}

__PACKAGE__->meta->make_immutable;

1;
