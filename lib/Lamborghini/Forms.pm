package Lamborghini::Forms;

use HTML::FormHandler::Moose;
use Method::Signatures::Simple;
use Lamborghini::I18N;
extends 'HTML::FormHandler::Model::DBIC';
with 'HTML::FormHandler::Render::Simple';

has '+field_name_space' => ( default => 'Lamborghini::Forms::Fields' );

method _build_language_handle {
    Lamborghini::I18N::i_default->new;
}

after 'BUILD' => sub {
    my $class = 'HTML::FormHandler::Field';
    $class->meta->make_mutable;
    Moose::Util::apply_all_roles( $class->meta,
        ('Lamborghini::Roles::HFHI18N') );
    $class->meta->make_immutable;
};

__PACKAGE__->meta->make_immutable;

1;
