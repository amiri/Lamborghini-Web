package Lamborghini::Roles::HFHI18N;

use Moose::Role;
use Method::Signatures::Simple;

method _localize {
    #shift->ctx->loc(@_);
    shift;
}

1;
