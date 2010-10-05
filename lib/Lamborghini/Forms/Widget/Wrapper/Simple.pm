package Lamborghini::Forms::Widget::Wrapper::Simple;

use Moose::Role;
with 'HTML::FormHandler::Widget::Wrapper::Base';

sub wrap_field {
    my ( $self, $result, $rendered_widget ) = @_;
    my $t;
    my $start_tag =
        defined( $t = $self->get_tag('wrapper_start') )
        ? $t
        : '<div id="' . $self->name . '_div" <%class%>><label class="label" for="' . $self->name . '"></label><span id="' . $self->name . '_span"></span>';
    my $is_compound = $self->has_flag('is_compound');
    my $class       = $self->render_class($result);
    my $output      = "\n";

    $start_tag =~ s/<%class%>/$class/g;
    $output .= $start_tag;

    #if ($is_compound) {
        #$output .=
            #'<fieldset class="' . $self->html_name . ' compound span-4">';
    #}
    #elsif ( !$self->has_flag('no_render_label')
        #&& length( $self->label ) > 0 )
    #{
    #}

    $output .= $rendered_widget;
    $output .= qq{\n<span class="error_message">$_</span>}
        for $result->all_errors;
    #$output .= '</fieldset>'
        #if $is_compound;

    $output .= defined( $t = $self->get_tag('wrapper_end') ) ? $t : '</div>';

    return "$output\n";
}

1;
