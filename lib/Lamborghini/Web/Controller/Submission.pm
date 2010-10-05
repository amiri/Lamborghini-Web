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
            $c->req->params->{'file1'} = $c->req->upload('file1') if $c->req->params->{'file1'};
            $c->req->params->{'file2'} = $c->req->upload('file2') if $c->req->params->{'file2'};
            $c->req->params->{'file3'} = $c->req->upload('file3') if $c->req->params->{'file3'};
            $c->req->params->{'file4'} = $c->req->upload('file4') if $c->req->params->{'file4'};
    }
    $form->process(
        ctx           => $c,
        item          => $new_user,
        params        => $c->req->params,
        picture_dir   => $c->config->{"Model::Picture"}->{user_picture_dir},
        thumbnail_dir => $c->config->{"Model::Picture"}->{user_thumbnail_dir},
    );
    $c->stash( fillinform => $form->fif, );
    return unless $form->validated;
    for my $upload ( 1 .. 4 ) {
        print STDERR "My file name value to be saved is: ",
            $form->field("file$upload")->value, "\n";

        my $new_picture = $c->model('DB::Picture')->create(
            {   user        => $new_user->id,
                file        => $upload . $form->field("file$upload")->value,
                description => "Upload $upload for " . $new_user->email,
            }
        ) if $form->field("file$upload")->value;
    }
    $c->flash( status_msg => "Thank you for submitting your information." );
    $c->res->redirect( $c->uri_for('/') );
}

__PACKAGE__->meta->make_immutable;

1;
