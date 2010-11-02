package HTML::FormHandler::Field::Multiple;
# ABSTRACT: multiple select list

use Moose;
extends 'HTML::FormHandler::Field::Select';
our $VERSION = '0.01';

has '+multiple' => ( default => 1 );
has '+size'     => ( default => 5 );

sub sort_options {
    my ( $self, $options ) = @_;

    my $value = $self->value;
    # This places the currently selected options at the top of the list
    # Makes the drop down lists a bit nicer
    if ( @$options && defined $value ) {
        my %selected = map { $_ => 1 } ref($value) eq 'ARRAY' ? @$value : ($value);

        my @out = grep { $selected{ $_->{value} } } @$options;
        push @out, grep { !$selected{ $_->{value} } } @$options;

        return \@out;
    }
    return $options;
}


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::Multiple - multiple select list

=head1 VERSION

version 0.32003

=head1 DESCRIPTION

This inherits from the Select field,
and sets the "multiple" flag true to accept multiple options.

The currently selected items will be put at the top of the list.
Widget type is 'select'.

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

