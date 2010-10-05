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

has_field 'file1' => (
    type             => 'Upload',
    max_size         => '5242880',
    required         => 1,
    required_message => 'You must upload at least one picture',
);

has_field 'file2' => (
    type     => 'Upload',
    max_size => '5242880',
);
has_field 'file3' => (
    type     => 'Upload',
    max_size => '5242880',
);
has_field 'file4' => (
    type     => 'Upload',
    max_size => '5242880',
);

method check_em {
    my $field = shift;
    print STDERR "My field name in fileupload is: ", $field->name, "\n";
    print STDERR "My field value in fileupload is: ", $field->value, "\n";
    print STDERR "My field value in fileupload isa: ", ref $field->value, "\n";
    $field->add_error('This file is too large. Files must be under 5MB.')
        if ( $field->value->size > 5242880 );

    $field->add_error('That is not a valid image file')
        unless $self->validator->validate_image( $field->value );
}

method validate_file1 {
    $self->check_em( $self->field('file1') );
}
method validate_file2 {
    $self->check_em( $self->field('file2') );
}
method validate_file3 {
    $self->check_em( $self->field('file3') );
}
method validate_file4 {
    $self->check_em( $self->field('file4') );
}

method validate {
    print STDERR ref $self, "\n";
    my @upload_fields;
    for (qw/file1 file2 file3 file4/) {
        push @upload_fields, $self->field($_) if $self->field($_)->value;
    }
    #$self->field('file2'), $self->field('file3'), $self->field('file4'));
    my $picture_name;
    print STDERR "In validate I have this many upload fields: ", scalar @upload_fields, "\n";
    if ( $self->field('owner') && $self->field('owner')->value ) {
        ( my $title = $self->field('title')->value ) =~ s/\s+/_/g;
        $picture_name = lc $title;
    }
    else {
        my $title = $self->field('first_name')->value . "_"
            . $self->field('last_name')->value;
        $picture_name = lc $title;
    }

    my $i = 1;
    for my $upload_field (@upload_fields) {
        $self->validator->process_image(
            $self->picture_dir,   $self->thumbnail_dir,
            $upload_field->value, $picture_name . $i
        );

            $upload_field->value( $picture_name . $i . ".jpg" );
            print STDERR "My upload field value after storing the string in it is: ", $upload_field->value, "\n";
        $i++;
    }
}

1;
