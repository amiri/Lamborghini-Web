package Lamborghini::Web::View::TT;

use Moose;
extends 'Catalyst::View::TT';
with 'Catalyst::View::FillInForm';

__PACKAGE__->config();

1;
