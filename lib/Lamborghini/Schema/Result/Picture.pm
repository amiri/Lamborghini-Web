package Lamborghini::Schema::Result::Picture;

use Moose;
extends 'Lamborghini::Schema::Result';

__PACKAGE__->table("picture");
__PACKAGE__->resultset_class('Lamborghini::Schema::ResultSet');
__PACKAGE__->add_columns(
    "id",
    { "data_type" => "integer", is_nullable => 0, is_auto_increment => 1, },
    "date_created",
    {   data_type     => "datetime",
        set_on_create => 1,
        is_nullable   => 0,
    },
    "date_modified",
    {   data_type     => "datetime",
        set_on_create => 1,
        set_on_update => 1,
        is_nullable   => 0,
    },
    "user",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
    "file",
    { data_type => "text", is_nullable => 0 },
    "title",
    { data_type => "text", is_nullable => 1 },
    "description",
    { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint( [qw/title/] );
__PACKAGE__->add_unique_constraint( [qw/description/] );
__PACKAGE__->belongs_to(
    "owner",
    "Lamborghini::Schema::Result::User",
    { "foreign.id" => "self.user" },
);

1;
