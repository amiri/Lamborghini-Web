package Lamborghini::Roles::FileUpload;

use Moose::Role;
use HTML::FormHandler::Moose::Role;
use Method::Signatures::Simple;
use aliased 'Lamborghini::Web::Model::Picture';
use namespace::autoclean;

has 'enctype' => ( is => 'ro', default => 'multipart/form-data' );

has 'thumbnail_dir' => (
    is     => 'rw',
    isa    => 'Path::Class::Dir',
    coerce => 1,
);

has 'picture_dir' => (
    is     => 'rw',
    isa    => 'Path::Class::Dir',
    coerce => 1,
);

has 'validator' => (
    is      => 'ro',
    isa     => Picture,
    lazy    => 1,
    default => sub {
        return Picture->new;
    },
);

has_field 'file' => (
    type             => 'Upload',
    max_size         => '5242880',
    required         => 1,
    required_message => 'You must upload a picture',
    label => 'Your photo',
);

method validate_file {
    my $file_field = $self->field('file');

    $self->field('file')
        ->add_error('This file is too large. Files must be under 5MB.')
        if ( $file_field->value->size > 5242880 );

    $self->field('file')->add_error('That is not a valid image file')
        unless $self->validator->validate_image( $file_field->value );
}

method validate {
    my $upload = $self->field('file')->value;

    my $picture_name;
    if ( $self->field('owner') && $self->field('owner')->value ) {
        ( my $title = $self->field('title')->value ) =~ s/\s+/_/g;
        $picture_name = lc $title;
    }
    else {
        my $title =
              $self->field('first_name')->value . "_"
            . $self->field('last_name')->value;
        $picture_name = lc $title;
    }

    $self->validator->process_image( $self->picture_dir, $self->thumbnail_dir,
        $upload, $picture_name );

    if ( $self->field('file')->value ) {
        $self->field('file')->value( $picture_name . ".jpg" );
    }
}

1;
