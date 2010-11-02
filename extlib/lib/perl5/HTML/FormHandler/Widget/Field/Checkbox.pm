package HTML::FormHandler::Widget::Field::Checkbox;
# ABSTRACT: HTML attributes field role

use Moose::Role;
use namespace::autoclean;

with 'HTML::FormHandler::Widget::Field::Role::HTMLAttributes';

sub render {
    my $self = shift;
    my $result = shift || $self->result;
    my $checkbox_value = $self->checkbox_value;

    my $output = '<input type="checkbox" name="'
        . $self->html_name . '" id="' . $self->id . '" value="'
        . $self->html_filter($checkbox_value) . '"';
    $output .= ' checked="checked"'
        if $result->fif eq $checkbox_value;
    $output .= $self->_add_html_attributes;
    $output .= ' />';

    return $self->wrap_field( $result, $output );
}

1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Field::Checkbox - HTML attributes field role

=head1 VERSION

version 0.32003

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

