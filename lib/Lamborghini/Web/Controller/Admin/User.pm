package Lamborghini::Web::Controller::Admin::User;

use Moose;
use DBIx::Class::ResultClass::HashRefInflator;
use namespace::autoclean;
use aliased 'Lamborghini::Forms::UserForm';

BEGIN { extends qw/Lamborghini::Web::Controller::Admin/; }

with 'Lamborghini::Web::ControllerRole::CRUD';

__PACKAGE__->config(
    model_name => 'DB::User',
    class      => 'User',
    item_name  => 'user',
    form       => 'Lamborghini::Forms::UserForm',
    actions    => {
        base => {
            PathPart    => ['user'],
            Chained     => ['admin_base'],
            CaptureArgs => 0
        }
    },
);

__PACKAGE__->meta->make_immutable;

1;
