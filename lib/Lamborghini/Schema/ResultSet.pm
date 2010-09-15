package Lamborghini::Schema::ResultSet;

use Moose;
use Lamborghini::Type::Library qw/:all/;
extends 'DBIx::Class::ResultSet';

__PACKAGE__->load_components("Helper::ResultSet::Random");

1;
