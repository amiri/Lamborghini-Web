package Lamborghini::Type::Library;

use Regexp::Common 'RE_ALL';
use Email::Valid;
use MooseX::Types::Moose qw/Bool Value Num Int Str ArrayRef HashRef Object/;
use MooseX::Types::Common::String
    qw/SimpleStr NonEmptySimpleStr StrongPassword NonEmptyStr/;
use MooseX::Types::URI qw/Uri FileUri/;
use Moose::Util::TypeConstraints;
use DateTime;
use Net::DNS;
use Net::Domain::TLD;
use Data::Dumper;
use List::MoreUtils qw/any/;
use Locale::Country;
use Locale::US;
use Number::Phone::US;

use utf8;

use MooseX::Types -declare => [
    qw/
        LamborghiniDateTime
        LamborghiniEmail
        LamborghiniFirstname
        LamborghiniLastname
        LamborghiniObscenity
        LamborghiniPassword
        LamborghiniState
        LamborghiniZip
        LamborghiniPhone
        /
];

use namespace::autoclean;

our $STATES = Locale::US->new;

subtype LamborghiniEmail, as Str, where {
    Email::Valid->address( -address => "$_", -mxcheck => 1, -tldcheck => 1 );
}, message {"Not a valid e-mail address."};

subtype LamborghiniDateTime, as class_type('DateTime'),
    message {"Not a valid date or time"};

coerce LamborghiniDateTime, from Object, via {
    $_->isa('DateTime')
        ? $_
        : Params::Coerce::coerce( 'DateTime', $_ );
}, from Str, via {
    DateTimeX::Easy->new($_)
        or DateTimeX::Easy->parse($_);

}, from HashRef, via {
    DateTimeX::Easy->new( %{$_} )
        or DateTimeX::Easy->parse( %{$_} );
};

subtype LamborghiniFirstname, as NonEmptySimpleStr, where {
    /\A [\p{IsAlpha}]+ \z/xms;
}, message {"First name must be all alphabetical characters"};

subtype LamborghiniLastname, as NonEmptySimpleStr, where {
    /\A [\p{IsAlpha}]+ \z/xms;
}, message {"Last name must be all alphabetical characters"};

subtype LamborghiniPassword, as StrongPassword, where {
    length($_) >= 6
        && length($_) <= 12;
}, message {"Choose a stronger password."};

subtype LamborghiniObscenity, as Str, where {
    $_ !~ /$RE{profanity}/i;
}, message {"The text contains obscenity"};

subtype LamborghiniState, as Str, where {
    (          exists $STATES->{code2state}{ uc($_) }
            || exists $STATES->{state2code}{ uc($_) } );
}, message {'That is not a valid state'};
subtype LamborghiniZip, as Value, where {
    /^$RE{zip}{US}{-extended => 'allow'}$/;
}, message {"That is not a valid zip code"};
subtype LamborghiniPhone, as Str, where {
    Number::Phone::US::validate_number($_);
}, message {"That is not a valid phone number"};

__PACKAGE__->meta->make_immutable;

1;
