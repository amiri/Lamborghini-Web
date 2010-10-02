package Lamborghini::Forms::Fields::LamborghiniSubmit;

use Moose;
use Lamborghini::Type::Library qw/:all/;
extends 'HTML::FormHandler::Field::Submit';

has '+value' => ( default => 'Submit' );

__PACKAGE__->meta->make_immutable;

1;
