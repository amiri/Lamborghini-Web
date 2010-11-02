package HTML::FormHandler::Widget::Wrapper::Base;
# ABSTRACT: commong methods for widget wrappers

use Moose::Role;

sub render_label {
    my $self = shift;
    return '<label class="label" for="' . $self->id . '">' . $self->html_filter($self->loc_label) . ': </label>';
}

sub render_class {
    my ( $self, $result ) = @_;

    $result ||= $self->result;
    my $class = '';
    if ( $self->css_class || $result->has_errors ) {
        my @css_class;
        push( @css_class, split( /[ ,]+/, $self->css_class ) ) if $self->css_class;
        push( @css_class, 'error' ) if $result->has_errors;
        $class .= ' class="';
        $class .= join( ' ' => @css_class );
        $class .= '"';
    }
    return $class;
}

use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Wrapper::Base - commong methods for widget wrappers

=head1 VERSION

version 0.32003

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

