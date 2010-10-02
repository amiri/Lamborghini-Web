package Lamborghini::Forms::RoleForm;

use HTML::FormHandler::Moose;
use Lamborghini::Type::Library qw/:all/;
extends 'Lamborghini::Forms';

has '+item_class' => ( default => 'Role' );

has_field 'role' => ( type => 'Text', required => 1, );
has_field '+submit' => ( type => '+LamborghiniSubmit', );

__PACKAGE__->meta->make_immutable;

1;
