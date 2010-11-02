package HTML::FormHandler::Field::Integer;
# ABSTRACT: validate an integer value

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Field::Text';
our $VERSION = '0.02';

has '+size' => ( default => 8 );

apply(
    [
        {
            transform => sub {
                my $value = shift;
                $value =~ s/^\+//;
                return $value;
                }
        },
        {
            check => sub { $_[0] =~ /^-?[0-9]+$/ },
            message => 'Value must be an integer'
        }
    ]
);


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::Integer - validate an integer value

=head1 VERSION

version 0.32003

=head1 DESCRIPTION

This accpets a positive or negative integer.  Negative integers may
be prefixed with a dash.  By default a max of eight digits are accepted.
Widget type is 'text'.

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

