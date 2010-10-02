package Lamborghini::Web::Controller::Admin::UserRole;

use Moose;
use DBIx::Class::ResultClass::HashRefInflator;
use namespace::autoclean;
use aliased 'Lamborghini::Forms::UserRoleForm';

BEGIN { extends qw/Lamborghini::Web::Controller::Admin/; }

with 'Lamborghini::Web::ControllerRole::CRUD';

__PACKAGE__->config(
    model_name => 'DB::UserRole',
    class      => 'UserRole',
    item_name  => 'userrole',
    form       => 'Lamborghini::Forms::UserRoleForm',
    actions    => {
        base => {
            PathPart    => ['userrole'],
            Chained     => ['admin_base'],
            CaptureArgs => 0
        }
    },
);

__PACKAGE__->meta->make_immutable;

1;
