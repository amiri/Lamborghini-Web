package URI::FromHash;

use strict;
use warnings;

use base 'Exporter';

use vars qw( $VERSION @EXPORT_OK );

$VERSION = '0.03';
@EXPORT_OK = qw( uri uri_object );

use Params::Validate qw( validate SCALAR ARRAYREF HASHREF );

use URI;
use URI::QueryParam;


my %BaseParams =
    ( scheme   => { type => SCALAR, optional => 1 },
      username => { type => SCALAR, optional => 1 },
      password => { type => SCALAR, default  => '' },
      host     => { type => SCALAR, optional => 1 },
      port     => { type => SCALAR, optional => 1 },
      path     => { type => SCALAR | ARRAYREF, optional => 1 },
      query    => { type => HASHREF, default => {} },
      fragment => { type => SCALAR,  optional => 1 },
    );

sub uri_object
{
    my %p = validate( @_, \%BaseParams );
    _check_required(\%p);

    my $uri = URI->new();

    $uri->scheme( $p{scheme} )
        if grep { defined && length } $p{scheme};

    if ( grep { defined && length } $p{username}, $p{password} )
    {
        $p{username} ||= '';
        $p{password} ||= '';
        if ( $uri->can('user') && $uri->can('password') )
        {
            $uri->user( $p{username} );
            $uri->password( $p{password} );
        }
        else
        {
            $uri->userinfo( "$p{username}:$p{password}" );
        }
    }

    for my $k ( qw( host port ) )
    {
        $uri->$k( $p{$k} )
            if grep { defined && length } $p{$k};
    }

    if ( $p{path} )
    {
        if ( ref $p{path} )
        {
            $uri->path( join '/', grep { defined } @{ $p{path} } );
        }
        else
        {
            $uri->path( $p{path} );
        }
    }

    while ( my ( $k, $v ) = each %{ $p{query} } )
    {
        $uri->query_param( $k => $v );
    }

    $uri->fragment( $p{fragment} )
        if grep { defined && length } $p{fragment};

    return $uri;
}

sub uri
{
    my %p = validate( @_,
                      { %BaseParams,
                        query_separator => { type => SCALAR, default => ';' },
                      },
                    );
    _check_required(\%p);

    my $sep = delete $p{query_separator};
    my $uri = uri_object(%p);

    if ( $sep ne '&' && $uri->query() )
    {
        my $query = $uri->query();
        $query =~ s/&/$sep/g;
        $uri->query($query);
    }

    # force stringification
    return $uri->canonical() . '';
}

sub _check_required
{
    my $p = shift;

    return if
        ( grep { defined and length }
          map { $p->{$_} }
          qw( host fragment )
        );

    return if
        ref $p->{path}
        ? @{ $p->{path} }
        : defined $p->{path} && length $p->{path};

    return if keys %{ $p->{query} };

    require Carp;
    local $Carp::CarpLevel = 1;
    Carp::croak( 'None of the required parameters '
                 . '(host, path, fragment, or query) were given' );
}


1;

__END__

=head1 NAME

URI::FromHash - Build a URI from a set of named parameters

=head1 SYNOPSIS

  use URI::FromHash qw( uri );

  my $uri = uri( path  => '/some/path',
                 query => { foo => 1, bar => 2 },
               );

=head1 DESCRIPTION

This module provides a simple one-subroutine "named parameters" style
interface for creating URIs. Underneath the hood it uses C<URI.pm>,
though because of the simplified interface it may not support all
possible options for all types of URIs.

It was created for the common case where you simply want to have a
simple interface for creating syntactically correct URIs from known
components (like a path and query string). Doing this using the native
C<URI.pm> interface is rather tedious, requiring a number of method
calls, which is particularly ugly when done inside a templating system
such as Mason or TT2.

=head1 FUNCTIONS

This module provides two functions both of which are I<optionally>
exportable:

=head2 uri( ... ) and uri_object( ... )

Both of these functions accept the same set of parameters, except for
one additional parameter allowed when calling C<uri()>.

The C<uri()> function simply returns a string representing a
canonicalized URI based on the provided parameters. The
C<uri_object()> function returns new a C<URI.pm> object based on the
given parameters.

These parameters are:

=over 4

=item * scheme

The URI's scheme. This is optional, and if none is given you will
create a schemeless URI. This is useful if you want to create a URI to
a path on the same server (as is commonly done in C<< <a> >> tags).

=item * host

=item * port

=item * path

The path can be either a string or an array reference.

If an array reference is passed each I<defined> member of the array
will be joined by a single forward slash (/).

If you are building a host-less URI and want to include a leading
slash then make the first element of the array reference an empty
string (C<''>).

You can add a trailing slash by making the last element of the array
reference an empty string.

=item * username

=item * password

=item * fragment

All of these are optional strings which can be used to specify that
part of the URI.

=item * query

This should be a hash reference of query parameters. The values for
each key may be a scalar or array reference. Use an array reference to
provide multiple values for one key.

=item * query_separator

This option is can I<only> be provided when calling C<uri()>. By
default, it is a semi-colon (;).

=back

=back

=head1 AUTHOR

Dave Rolsky, <autarch@urth.org>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-uri-fromhash@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically be
notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2006-2008 Dave Rolsky, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
