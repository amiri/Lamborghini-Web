package HTML::FormHandler::Field::Money;
# ABSTRACT: US currency-like values

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Field::Text';
our $VERSION = '0.01';

apply(
    [
        {
            transform => sub {
                my $value = shift;
                $value =~ s/^\$//;
                return $value;
                }
        },
        {
            transform => sub { sprintf '%.2f', $_[0] },
            message   => 'Value cannot be converted to money'
        },
        {
            check => sub { $_[0] =~ /^-?\d+\.?\d*$/ },
            message => 'Value must be a real number'
        }
    ]
);


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::Money - US currency-like values

=head1 VERSION

version 0.32003

=head1 DESCRIPTION

Validates that a postive or negative real value is entered.
Formatted with two decimal places.

Uses a period for the decimal point. Widget type is 'text'.

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

