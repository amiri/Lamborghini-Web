#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Path::Class;
use File::Slurp qw/slurp write_file/;
use Moose;
use MooseX::Types::Path::Class;

with 'MooseX::Getopt';

has 'origin' => (
    is       => 'rw',
    isa      => 'Path::Class::Dir',
    required => 1,
    coerce   => 1,
    default  => "$FindBin::Bin/../lib/Lamborghini/Schema/Result",
);

has 'destination' => (
    is       => 'rw',
    isa      => 'Path::Class::Dir',
    required => 1,
    coerce   => 1,
    default  => "$FindBin::Bin/../lib/Lamborghini/Forms",
);

has 'schema' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
    default  => 'Lamborghini::Schema',
);

has 'dsn' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
    default  => 'dbi:SQLite:dbname=lamborghini.db',
);

has 'dbuser' => (
    is       => 'ro',
    default  => '',
);
has 'dbpass' => (
    is       => 'ro',
    default  => '',
);

sub run {
    my ($self) = @_;
    for my $child ( $self->origin->children ) {
        print "Resultset: $child\n";
        ( my $filename = $child )    =~ s/^.*\///g;
        ( my $rsname   = $filename ) =~ s/\.pm//g;
        my $modulename  = $rsname . 'Form' . '.pm';
        my $formname    = $rsname . 'Form';
        my $schema      = $self->schema;
        my $destination = $self->destination;
        #my $dbuser      = $self->dbuser;
        #my $dbpass      = $self->dbpass;
        my $dsn         = $self->dsn;

        print
            "form_generator.pl --rs_name=$rsname --schema_name=$schema --db_dsn=$dsn > $destination/$filename\n";
        system(
            "form_generator.pl --rs_name=$rsname --schema_name=$schema --db_dsn=$dsn > $destination/$modulename"
        );
        my @lines = slurp("$destination/$modulename");
        for (@lines) {
            if ( $_ =~ /package/ ) {
                s/package ($formname)/package Lamborghini::Forms::$1/g;
            }
        }
        write_file( "$destination/$modulename", @lines );
    }
}

__PACKAGE__->meta->make_immutable;
__PACKAGE__->new_with_options->run unless caller;
