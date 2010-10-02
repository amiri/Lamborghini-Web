package Lamborghini::Forms::LoginForm;

use HTML::FormHandler::Moose;
use Lamborghini::Type::Library qw/:all/;
extends 'HTML::FormHandler';

has '+field_name_space' => ( default => 'Lamborghini::Forms::Fields' );

has_field 'email' => (
    type     => 'Email',
    required => 1,
);

has_field 'password' => (
    type     => 'Password',
    required => 1,
);

has_field '+submit' => ( type => '+LamborghiniSubmit', );

__PACKAGE__->meta->make_immutable;

1;
