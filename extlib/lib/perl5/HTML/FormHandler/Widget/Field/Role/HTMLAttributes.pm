package HTML::FormHandler::Widget::Field::Role::HTMLAttributes;
# ABSTRACT: apply HTML attributes

use Moose::Role;

sub _add_html_attributes {
    my $self = shift;

    my $output = q{};
    for my $attr ( 'readonly', 'disabled', 'style', 'title' ) {
        $output .= ( $self->$attr ? qq{ $attr="} . $self->$attr . '"' : '' );
    }
    $output .= ($self->javascript ? ' ' . $self->javascript : '');
    if( $self->input_class ) {
        $output .= ' class="' . $self->input_class . '"';
    }
    return $output;
}

1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Field::Role::HTMLAttributes - apply HTML attributes

=head1 VERSION

version 0.32003

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

