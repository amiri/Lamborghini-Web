package Lamborghini::Web::Controller::Admin::Role;

use Moose;
use DBIx::Class::ResultClass::HashRefInflator;
use namespace::autoclean;
use aliased 'Lamborghini::Forms::RoleForm';

BEGIN { extends qw/Lamborghini::Web::Controller::Admin/; }

with 'Lamborghini::Web::ControllerRole::CRUD';

__PACKAGE__->config(
    model_name => 'DB::Role',
    class      => 'Role',
    item_name  => 'role',
    form       => 'Lamborghini::Forms::RoleForm',
    actions    => {
        base => {
            PathPart    => ['role'],
            Chained     => ['admin_base'],
            CaptureArgs => 0
        }
    },
);

__PACKAGE__->meta->make_immutable;

1;
