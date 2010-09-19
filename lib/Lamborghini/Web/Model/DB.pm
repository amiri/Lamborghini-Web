package Lamborghini::Web::Model::DB;

use Moose;
extends 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'Lamborghini::Schema',
    connect_info => {
        dsn          => 'dbi:SQLite:dbname=lamborghini.db',
        user         => '',
        sqlt_unicode => 1,
        quote_char   => q/"/,
        name_sep     => q/./,
        autocommit   => 1,
    }
);

__PACKAGE__->meta->make_immutable;

1;
