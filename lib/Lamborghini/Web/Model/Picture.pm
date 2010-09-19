package Lamborghini::Web::Model::Picture;

use Imager;
use Path::Class;
use namespace::autoclean;
use Data::Dumper;
use Moose;
use Try::Tiny;
use Devel::Dwarn;

BEGIN { extends 'Catalyst::Controller'; }

has 'image_processor' => (
    is      => 'ro',
    isa     => 'Imager',
    lazy    => 1,
    builder => '_image_processor',
);

sub _image_processor {
    my $self = shift;
    return Imager->new();
}

sub validate_image {
    my ( $self, $upload ) = @_;
    return 0 unless $upload;
    return 0 unless $upload->tempname;
    $self->image_processor->open( file => $upload->tempname );
}

sub make_thumbnail {
    my ( $self, $image_path, $thumb_dir, $filename ) = @_;

    my $image = $self->image_processor->read( file => $image_path )
        or die $self->image_processor->errstr();

    my $thumb = $image->scale( ypixels => 60 );

    $thumb->write( file => "$thumb_dir/$filename", jpegquality => 80 )
        or die $thumb->errstr;
}

sub process_image {
    my ( $self, $output_dir, $thumb_dir, $upload ) = @_;

    if ( $self->validate_image($upload) ) {
        my $file_path = dir( $output_dir, $upload->basename );

        $upload->copy_to($file_path);

        $self->make_thumbnail( $file_path, $thumb_dir, $upload->basename );
    }
}

__PACKAGE__->meta->make_immutable;

1;
