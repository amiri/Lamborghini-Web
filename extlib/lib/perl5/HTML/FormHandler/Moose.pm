package  HTML::FormHandler::Moose;
# ABSTRACT: to add FormHandler sugar

use Moose;
use Moose::Exporter;
use Moose::Util::MetaRole;
use HTML::FormHandler::Meta::Role;
use constant HAS_MOOSE_V109_METAROLE => ($Moose::VERSION >= 1.09);


Moose::Exporter->setup_import_methods(
    with_meta => [ 'has_field', 'apply' ],
    also        => 'Moose',
);

sub init_meta {
    my $class = shift;

    my %options = @_;
    Moose->init_meta(%options);
    my $meta;
    if (HAS_MOOSE_V109_METAROLE) {
        $meta = Moose::Util::MetaRole::apply_metaroles(
            for             => $options{for_class},
            class_metaroles => {
                class => [ 'HTML::FormHandler::Meta::Role' ]
            }
        );
    } else {
        $meta = Moose::Util::MetaRole::apply_metaclass_roles(
            for_class       => $options{for_class},
            metaclass_roles => ['HTML::FormHandler::Meta::Role'],
        );
    }
    return $meta;
}

sub has_field {
    my ( $meta, $name, %options ) = @_;
    my $names = ( ref($name) eq 'ARRAY' ) ? $name : [ ($name) ];

    $meta->add_to_field_list( { name => $_, %options } ) for @$names;
}

sub apply {
    my ( $meta, $arrayref ) = @_;

    $meta->add_to_apply_list( @{$arrayref} );
}

use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Moose - to add FormHandler sugar

=head1 VERSION

version 0.32003

=head1 SYNOPSIS

Enables the use of field specification sugar (has_field).
Use this module instead of C< use Moose; >

   package MyApp::Form::Foo;
   use HTML::FormHandler::Moose;
   extends 'HTML::FormHandler';

   has_field 'username' => ( type => 'Text', ... );
   has_field 'something_else' => ( ... );

   no HTML::FormHandler::Moose;
   1;

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

