package HTML::FormHandler::Widget::Form::Role::HTMLAttributes;
# ABSTRACT: set HTML attributes on the form tag

use Moose::Role;

sub html_form_tag {
    my $self = shift;

    my @attr_accessors = (
        [ action  => 'action' ],
        [ id      => 'name' ],
        [ method  => 'http_method' ],
        [ enctype => 'enctype' ],
        [ class   => 'css_class' ],
        [ style   => 'style' ],
    );

    my $output = '<form';
    foreach my $attr_pair (@attr_accessors) {
        my $accessor = $attr_pair->[1];
        if ( my $value = $self->$accessor ) {
            $output .= ' ' . $attr_pair->[0] . '="' . $value . '"';
        }
    }
    $output .= " >\n";
    return $output;
}

no Moose::Role;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Form::Role::HTMLAttributes - set HTML attributes on the form tag

=head1 VERSION

version 0.32003

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

