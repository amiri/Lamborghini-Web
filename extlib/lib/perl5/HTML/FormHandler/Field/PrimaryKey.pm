package HTML::FormHandler::Field::PrimaryKey;
# ABSTRACT: primary key field

use Moose;
extends 'HTML::FormHandler::Field';


has 'is_primary_key' => ( isa => 'Bool', is => 'ro', default => '1' );
has '+widget' => ( default => 'hidden' );

__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::PrimaryKey - primary key field

=head1 VERSION

version 0.32003

=head1 SYNOPSIS

   has_field 'addresses.address_id' => ( type => 'PrimaryKey' );

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

