package Lamborghini::Schema::Result;

use Moose;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components(
    "InflateColumn::DateTime",     "TimeStamp",
    "InflateColumn::Object::Enum", "Helper::Row::ToJSON",
);

1;
