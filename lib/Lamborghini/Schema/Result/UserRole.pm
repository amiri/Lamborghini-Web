package Lamborghini::Schema::Result::UserRole;

use Moose;
extends 'Lamborghini::Schema::Result';

__PACKAGE__->table("user_role");
__PACKAGE__->resultset_class('Lamborghini::Schema::ResultSet');
__PACKAGE__->add_columns(
    "user",
    { "data_type" => "integer", is_nullable => 0, is_foreign_key => 1, },
    "role",
    { data_type => "integer", is_nullable => 0, is_foreign_key => 1, },
);
__PACKAGE__->set_primary_key(qw/user role/);
__PACKAGE__->belongs_to(
    "user",
    "Lamborghini::Schema::Result::User",
    { "foreign.id" => "self.user" },
);
__PACKAGE__->belongs_to(
    "role",
    "Lamborghini::Schema::Result::Role",
    { "foreign.id" => "self.role" },
);

1;
