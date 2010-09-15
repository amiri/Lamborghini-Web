package Lamborghini::Testing;

use Moose;
use Test::More;
use Test::Moose;
use aliased 'Test::WWW::Mechanize::Catalyst' => 'Bot';
use Method::Signatures::Simple;
use Catalyst::Request::Upload;
use File::MimeInfo::Magic;
extends 'Lamborghini::Web::Model';

sub import {
    my ( $class, @args ) = @_;
    my $caller = caller;
    warnings->import();
    strict->import();
    feature->import(':5.10');
    mro::set_mro( scalar caller(), 'c3' );
    eval
        "package $caller; use Module::Find; use Test::Deep; use Test::Exception; use Test::Warn; use Test::More; use Devel::Dwarn; use Data::Dumper; use HTML::Lint; use Test::Moose; use IO::All -utf8; use JSON::XS; use FindBin; use Devel::Dwarn;";
}

has 'bot' => (
    is      => 'ro',
    isa     => Bot,
    lazy    => 1,
    default => sub { Bot->new( catalyst_app => 'Lamborghini::Web' ) },
);

has 'json_xs' => (
    is   => 'ro',
    isa  => "JSON::XS",
    lazy => 1,
    default =>
        sub { JSON::XS->new->utf8->pretty->convert_blessed->allow_nonref },
);

sub make_file_upload {
    my ( $self, $file ) = @_;
    return Catalyst::Request::Upload->new(
        fh       => $file,
        size     => $file->size,
        filename => $file->filename,
        tempname => $file->absolute->pathname,
        type     => mimetype($file),
    );
}

1;
