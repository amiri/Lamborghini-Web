package Lamborghini::Forms::PictureForm;

use HTML::FormHandler::Moose;
use Lamborghini::Type::Library qw/:all/;
extends 'Lamborghini::Forms';
with 'Lamborghini::Roles::FileUpload';

use DateTime;

has '+item_class' => ( default => 'Picture' );

has_field 'description' => ( type => 'Text', );
has_field 'title'       => ( type => 'Text', );
has_field 'owner'       => ( type => 'Select', label_column => 'email' );
has_field '+submit'     => ( type => '+LamborghiniSubmit', );

__PACKAGE__->meta->make_immutable;

1;
