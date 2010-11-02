package HTML::FormHandler::Field::Radio;
# ABSTRACT: not used

use Moose;
extends 'HTML::FormHandler::Field';


has 'radio_value' => ( is => 'rw', default => 1 );

has '+widget' => ( default => 'radio' );

__PACKAGE__->meta->make_immutable;
use namespace::autoclean;
1;

__END__
=pod

=head1 NAME

HTML::FormHandler::Field::Radio - not used

=head1 VERSION

version 0.32003

=head1 SYNOPSIS

This field is not currently used. Placeholder for possible future
atomic radio buttons.

  <label class="label" for="[% field.name %]">[% field.label</label>
  <input name="[% field.name %]" type="radio"
    value="[% field.radio_value %]"
    [% IF field.fif == field.radio_value %]
       select="selected"
    [% END %]
   />

=head2 radio_value

See synopsis. Sets the value used in the radio button.

=head1 AUTHOR

FormHandler Contributors - see HTML::FormHandler

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Gerda Shank.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

