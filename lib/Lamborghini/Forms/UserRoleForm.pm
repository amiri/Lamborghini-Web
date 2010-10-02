package Lamborghini::Forms::UserRoleForm;

use HTML::FormHandler::Moose;
use Lamborghini::Type::Library qw/:all/;
extends 'Lamborghini::Forms';
with 'HTML::FormHandler::Render::Simple';

has '+item_class' => ( default => 'UserRole' );

has_field 'user'    => ( type => 'Select', );
has_field 'role'    => ( type => 'Select', );
has_field '+submit' => ( type => '+LamborghiniSubmit', );

1;
