package HTML::FormHandler::Field::Email;
# ABSTRACT: validates email using Email::Valid

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Field::Text';
use Email::Valid;
our $VERSION = '0.02';

apply(
    [
        {
            transform => sub { lc( $_[0] ) }
        },
        {
            check => sub { Email::Valid->address( $_[0] ) },
            message => [ 'Email should be of the format [_1]', 'someuser@example.com' ]
        }
    ]
);


__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::Email - validates email using Email::Valid

=head1 VERSION

version 0.32003

=head1 DESCRIPTION

Validates that the input looks like an email address uisng L<Email::Valid>.
Widget type is 'text'.

=head1 DEPENDENCIES

L<Email::Valid>

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

