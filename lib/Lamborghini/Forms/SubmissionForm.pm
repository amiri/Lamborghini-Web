package Lamborghini::Forms::SubmissionForm;

use HTML::FormHandler::Moose;
use DateTime;
use Method::Signatures::Simple;
use Lamborghini::Type::Library qw/:all/;
use aliased 'Lamborghini::Web::Model::Picture';
extends 'Lamborghini::Forms';

has '+item_class' => ( default => 'User' );
has '+enctype'    => ( default => 'multipart/form-data' );

has 'validator' => (
    is      => 'ro',
    isa     => Picture,
    lazy    => 1,
    default => sub {
        return Picture->new;
    },
);

has_field 'last_name' => (
    type             => 'Text',
    required         => 1,
    required_message => 'You must enter your last name',
);
has_field 'first_name' => (
    type             => 'Text',
    required         => 1,
    required_message => 'You must enter your first name',
);
has_field 'email' => (
    type             => 'Text',
    apply            => [LamborghiniEmail],
    required         => 1,
    unique           => 1,
    unique_message   => 'There is already a user with that e-mail address',
    required_message => 'You must enter your email address',
);

has_field 'file' => (
    type             => 'Upload',
    max_size         => '5242880',
    required         => 1,
    required_message => 'You must upload a picture',
);

has_field 'submit' => ( type => 'Submit', default => 'Submit', );

method validate_file {
    my $file_field = $self->field('file');

    $self->field('file')
        ->add_error('This file is too large. Files must be under 5MB.')
        if ( $file_field->value->size > 5242880 );

    $self->field('file')->add_error('That is not a valid image file')
        unless $self->validator->validate_image( $file_field->value );
}

__PACKAGE__->meta->make_immutable;

1;
