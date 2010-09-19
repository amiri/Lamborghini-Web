package Lamborghini::Forms::RoleForm;

use HTML::FormHandler::Moose;
extends 'Lamborghini::Forms';
with 'HTML::FormHandler::Render::Simple';

has '+item_class' => ( default => 'Role' );

has_field 'role' => ( type => 'Text', required => 1, );
has_field 'submit'     => ( widget => 'submit' );

__PACKAGE__->meta->make_immutable;

1;
