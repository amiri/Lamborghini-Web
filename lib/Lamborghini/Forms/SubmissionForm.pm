package Lamborghini::Forms::SubmissionForm;

use HTML::FormHandler::Moose;
extends 'Lamborghini::Forms';
with 'HTML::FormHandler::Render::Simple';

use DateTime;

has '+item_class' => ( default => 'User' );

has_field 'last_name'  => ( type => 'Text', );
has_field 'first_name' => ( type => 'Text', );
has_field 'email'      => ( type => 'Text', required => 1, );
has_field 'date_created' => (
    type  => 'Compound',
    apply => [
        {   transform => sub { DateTime->new( $_[0] ) },
            message   => "Not a valid DateTime",
        }
    ],
    default => DateTime->now,
);
has_field 'date_created.year' => ( type => 'Year', required => 1, );
has_field 'date_created.month' => ( type => 'Month', required => 1, );
has_field 'date_created.day' => ( type => 'MonthDay', required => 1, );
has_field 'submit'     => ( widget => 'submit', default => 'Submit' );

__PACKAGE__->meta->make_immutable;

1;
