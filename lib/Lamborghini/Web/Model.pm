package Lamborghini::Web::Model;

use Moose;
use Lamborghini::Schema;
extends 'Catalyst::Model';

has 'schema' => (
    is      => 'rw',
    isa     => 'Lamborghini::Schema',
    default => sub {
        return Lamborghini::Schema->connect(
            'dbi:SQLite:dbname=lamborghini.db',
            '', '',
            {   sqlt_unicode => 1,
                autocommit   => 1,
                quote_char   => q/"/,
                name_sep     => q/./,
            },
        );
    },
);

__PACKAGE__->meta->make_immutable;

1;
