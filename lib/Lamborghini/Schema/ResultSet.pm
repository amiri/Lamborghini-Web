package Lamborghini::Schema::ResultSet;

use Moose;
extends 'DBIx::Class::ResultSet';

__PACKAGE__->load_components("Helper::ResultSet::Random");

1;
