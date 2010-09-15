package Lamborghini::Schema::Result::User;

use Moose;
use Lamborghini::Type::Library qw/:all/;
extends 'Lamborghini::Schema::Result';

__PACKAGE__->table("user");
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
    "email",
    { data_type => "text", is_nullable => 0 },
    "first_name",
    { data_type => "text", is_nullable => 1 },
    "last_name",
    { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint( [qw/first_name last_name/] );
__PACKAGE__->add_unique_constraint( [qw/email/] );
__PACKAGE__->has_many(
    "pictures",
    "Lamborghini::Schema::Result::Picture",
    { "foreign.user" => "self.id" },
);
__PACKAGE__->has_many(
    "user_roles",
    "Lamborghini::Schema::Result::UserRole",
    { "foreign.user" => "self.id" },
);
__PACKAGE__->many_to_many(
    roles => "user_roles",
    "role"
);

1;
