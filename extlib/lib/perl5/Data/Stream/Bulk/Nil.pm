package Data::Stream::Bulk::Nil;
BEGIN {
  $Data::Stream::Bulk::Nil::AUTHORITY = 'cpan:NUFFIN';
}
BEGIN {
  $Data::Stream::Bulk::Nil::VERSION = '0.08';
}
# ABSTRACT: An empty L<Data::Stream::Bulk> iterator

use Moose;

use namespace::clean -except => 'meta';

with qw(Data::Stream::Bulk) => { -excludes => [qw/loaded filter list_cat all items/] };

sub items { return () }

sub all { return () }

sub next { undef }

sub is_done { 1 }

sub list_cat {
    my ( $self, $head, @rest ) = @_;

    return () unless $head;
    return $head->list_cat(@rest);
}

sub filter { return $_[0] };

sub loaded { 1 }

__PACKAGE__->meta->make_immutable;

__PACKAGE__;


__END__
=pod

=encoding utf-8

=head1 NAME

Data::Stream::Bulk::Nil - An empty L<Data::Stream::Bulk> iterator

=head1 SYNOPSIS

    return Data::Stream::Bulk::Nil->new; # empty set

=head1 DESCRIPTION

This iterator can be used to return the empty resultset.

=head1 METHODS

=head2 is_done

Always returns true.

=head2 next

Always returns undef.

=head2 items

=head2 all

Always returns the empty list.

=head2 list_cat

Skips $self

=head2 filter

Returns $self

=head2 loaded

Returns true.

=head1 AUTHOR

Yuval Kogman <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Yuval Kogman.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

