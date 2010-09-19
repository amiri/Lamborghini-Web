package Lamborghini::Forms::PictureForm;

use HTML::FormHandler::Moose;
extends 'Lamborghini::Forms';
with 'HTML::FormHandler::Render::Simple';

use DateTime;

has '+item_class' => ( default => 'Picture' );

has_field 'description' => ( type => 'Text', );
has_field 'title'       => ( type => 'Text', );
has_field 'file'        => ( type => 'Text', required => 1, );
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
has_field 'date_modified' => (
    type  => 'Compound',
    apply => [
        {   transform => sub { DateTime->new( $_[0] ) },
            message   => "Not a valid DateTime",
        }
    ],
    default => DateTime->now,
);
has_field 'date_modified.year' => ( type => 'Year', required => 1, );
has_field 'date_modified.month' => ( type => 'Month', required => 1, );
has_field 'date_modified.day' => ( type => 'MonthDay', required => 1, );
has_field 'owner'  => ( type   => 'Select', );
has_field 'submit' => ( widget => 'submit' );

__PACKAGE__->meta->make_immutable;

1;
