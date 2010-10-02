package Lamborghini::Web::Controller::Admin::Picture;

use Moose;
use DBIx::Class::ResultClass::HashRefInflator;
use namespace::autoclean;
use aliased 'Lamborghini::Forms::PictureForm';

BEGIN { extends qw/Lamborghini::Web::Controller::Admin/; }

with 'Lamborghini::Web::ControllerRole::CRUD';

__PACKAGE__->config(
    model_name => 'DB::Picture',
    class      => 'Picture',
    item_name  => 'picture',
    form       => 'Lamborghini::Forms::PictureForm',
    actions    => {
        base => {
            PathPart    => ['picture'],
            Chained     => ['admin_base'],
            CaptureArgs => 0
        }
    },
);

__PACKAGE__->meta->make_immutable;

1;
