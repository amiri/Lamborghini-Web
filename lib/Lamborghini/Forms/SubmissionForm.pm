package Lamborghini::Forms::SubmissionForm;

use HTML::FormHandler::Moose;
use DateTime;
use Method::Signatures::Simple;
use Lamborghini::Type::Library qw/:all/;
extends 'Lamborghini::Forms::UserForm';
with 'Lamborghini::Roles::FileUpload';

__PACKAGE__->meta->make_immutable;

1;
