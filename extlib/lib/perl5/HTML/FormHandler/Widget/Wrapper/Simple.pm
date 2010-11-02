package HTML::FormHandler::Widget::Wrapper::Simple;
# ABSTRACT: simple field wrapper

use Moose::Role;
use namespace::autoclean;

with 'HTML::FormHandler::Widget::Wrapper::Base';


sub wrap_field {
    my ( $self, $result, $rendered_widget ) = @_;
    my $t;
    my $start_tag = defined($t = $self->get_tag('wrapper_start')) ?
        $t : '<div<%class%>>';
    my $is_compound = $self->has_flag('is_compound');
    my $class  = $self->render_class($result);
    my $output = "\n";

    $start_tag =~ s/<%class%>/$class/g;
    $output .= $start_tag;

    if ( $is_compound ) {
        $output .= '<fieldset class="' . $self->html_name . '">';
        $output .= '<legend>' . $self->loc_label . '</legend>';
    }
    elsif ( !$self->has_flag('no_render_label') && length( $self->label ) > 0 ) {
        $output .= $self->render_label;
    }

    $output .= $rendered_widget;
    $output .= qq{\n<span class="error_message">$_</span>}
        for $result->all_errors;
    $output .= '</fieldset>'
        if $is_compound;

    $output .= defined($t = $self->get_tag('wrapper_end')) ? $t : '</div>';

    return "$output\n";
}

1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Widget::Wrapper::Simple - simple field wrapper

=head1 VERSION

version 0.32003

=head1 SYNOPSIS

This is the default wrapper role. It will be installed if
no other wrapper is specified and widget_wrapper is not set to
'none'.

It used the 'widget_tags' keys 'wrapper_start' and 'wrapper_end',
so that the default C<< '<div<%class>>' >> and C<< '</div>' >> tags
may be replaced. The following will cause the fields to be wrapped
in paragraph tags instead:

   has '+widget_tags' => ( default => sub { {
      wrapper_start => '<p>',
      wrapper_end   => '</p>' }
   );

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

