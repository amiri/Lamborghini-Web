package Lamborghini::Schema::Result::Session;

use Moose;
use Lamborghini::Type::Library qw/:all/;
extends 'Lamborghini::Schema::Result';

__PACKAGE__->table("session");
__PACKAGE__->resultset_class('Lamborghini::Schema::ResultSet');
__PACKAGE__->add_columns(
    "id",
    { data_type => "varchar", is_nullable => 0, size => 72 },
    "session_data",
    {   data_type       => "text",
        is_serializable => 1,
        is_nullable     => 1
    },
    "expires",
    { data_type => "integer", is_nullable => 1, is_serializable => 1, },
);

__PACKAGE__->set_primary_key("id");

1;
