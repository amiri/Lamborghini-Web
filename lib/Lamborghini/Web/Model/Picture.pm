package Lamborghini::Web::Model::Picture;

use Imager;
use Path::Class;
use namespace::autoclean;
use Data::Dumper;
use Moose;
use Try::Tiny;
use Devel::Dwarn;
use Method::Signatures::Simple;

BEGIN { extends 'Catalyst::Controller'; }

has 'image_processor' => (
    is      => 'ro',
    isa     => 'Imager',
    lazy    => 1,
    builder => '_image_processor',
);

method _image_processor {
    return Imager->new();
}

method validate_image($upload) {
    return 0
        unless $upload;
    return 0 unless $upload->tempname;
    $self->image_processor->open( file => $upload->tempname );
    }

    method make_thumbnail( $image_path, $thumb_dir, $filename ) {
    my $image = $self->image_processor->read( file => $image_path )
        or die $self->image_processor->errstr();

        my $thumb = $image->scale( ypixels => 60 );

        $thumb->write( file => "$thumb_dir/$filename", jpegquality => 80 )
        or die $thumb->errstr;
    }

    method process_image( $output_dir, $thumb_dir, $upload, $full_name ) {
    ( my $name = lc($full_name) ) =~ s/\s+/_/g;
        $name = $name . ".jpg";
        if ( $self->validate_image($upload) ) {
        my $file_path = dir( $output_dir, $name );

        $upload->copy_to($file_path);

        $self->make_thumbnail( $file_path, $thumb_dir, $name );
    }
    }

    __PACKAGE__->meta->make_immutable;

1;
