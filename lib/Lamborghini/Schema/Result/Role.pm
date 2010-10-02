package Lamborghini::Schema::Result::Role;

use Moose;
extends 'Lamborghini::Schema::Result';

__PACKAGE__->table("role");
__PACKAGE__->resultset_class('Lamborghini::Schema::ResultSet');
__PACKAGE__->add_columns(
    "id",
    { "data_type" => "integer", is_nullable => 0, is_auto_increment => 1, },
    "role", { data_type => "text", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->has_many(
    "user_roles",
    "Lamborghini::Schema::Result::UserRole",
    { "foreign.role" => "self.id" },
);

__PACKAGE__->many_to_many(
    "users" => "user_roles",
    "user"
);

1;
