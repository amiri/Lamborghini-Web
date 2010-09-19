package Lamborghini::Forms::UserForm;

use HTML::FormHandler::Moose;
extends 'Lamborghini::Forms';
with 'HTML::FormHandler::Render::Simple';

use DateTime;

has '+item_class' => ( default => 'User' );

has_field 'last_name'  => ( type => 'TextArea', );
has_field 'first_name' => ( type => 'TextArea', );
has_field 'email'      => ( type => 'TextArea', required => 1, );
has_field 'date_modified' => (
    type  => 'Compound',
    apply => [
        {   transform => sub { DateTime->new( $_[0] ) },
            message   => "Not a valid DateTime",
        }
    ],
);
has_field 'date_modified.year';
has_field 'date_modified.month';
has_field 'date_modified.day';
has_field 'date_created' => (
    type  => 'Compound',
    apply => [
        {   transform => sub { DateTime->new( $_[0] ) },
            message   => "Not a valid DateTime",
        }
    ],
);
has_field 'date_created.year';
has_field 'date_created.month';
has_field 'date_created.day';
has_field 'submit'     => ( widget => 'submit', default => 'Submit', );

__PACKAGE__->meta->make_immutable;

1;
