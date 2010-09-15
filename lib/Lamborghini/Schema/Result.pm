package Lamborghini::Schema::Result;

use Moose;
use Lamborghini::Type::Library qw/:all/;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components(
    "InflateColumn::DateTime",     "TimeStamp",
    "InflateColumn::Object::Enum", "Helper::Row::ToJSON",
    "EncodedColumn"
);

1;
