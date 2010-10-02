package Lamborghini::Forms::UserForm;

use HTML::FormHandler::Moose;
use Locale::US;
use Devel::Dwarn;
use Method::Signatures::Simple;
use Lamborghini::Type::Library qw/:all/;
extends 'Lamborghini::Forms';
with 'Lamborghini::Roles::FileUpload';

use DateTime;

has 'states' => (
    is      => 'ro',
    isa     => 'HashRef',
    default => sub {
        my %states;
        while (<DATA>) {
            chomp;
            my ( $code, $state ) = split ':';
            $states{$code} = $state;
        }
        return \%states;
    },
);

has '+item_class' => ( default => 'User' );

has_field 'first_name' => (
    type             => 'Text',
    required         => 1,
    required_message => 'You must enter your first name',
);
has_field 'middle_initial' => (
    type     => 'Text',
    required => 0,
    label    => 'Middle Initial',
);
has_field 'last_name' => (
    type             => 'Text',
    required         => 1,
    required_message => 'You must enter your last name',
);
has_field 'dob' => (
    type     => 'DateTime',
    required => 1,
    apply    => [to_LamborghiniDateTime],
    label    => 'Date of Birth',
);
has_field 'dob.day'   => ( type => 'MonthDay', required => 1 );
has_field 'dob.month' => ( type => 'Month',    required => 1 );
has_field 'dob.year' =>
    ( type => 'Year', range_start => 1960, required => 1 );

has_field 'email' => (
    type             => 'Text',
    apply            => [LamborghiniEmail],
    required         => 1,
    unique           => 1,
    unique_message   => 'There is already a user with that e-mail address',
    required_message => 'You must enter your email address',
);
has_field 'street_address' => (
    type             => 'Text',
    required         => 1,
    required_message => 'You must enter an address',
);
has_field 'city' => (
    type             => 'Text',
    required         => 1,
    required_message => 'You must enter a city',
);
has_field 'state' => (
    type             => 'Select',
    required         => 1,
    required_message => 'You must select a state',
    apply            => [LamborghiniState],
);
has_field 'zip' => (
    type             => 'Text',
    required         => 1,
    required_message => 'You must enter your zip code',
    apply            => [LamborghiniZip]
);
has_field 'phone' => (
    type             => 'Text',
    required         => 1,
    required_message => 'You must enter your phone number',
    apply            => [LamborghiniPhone]
);
has_field 'why' => (
    type     => 'TextArea',
    required => 1,
    label    => 'Tell us why U wanna become an Upgrade Girl',
);

has_field 'submit' => ( type => '+LamborghiniSubmit', );

method options_state {
    return [
        map { { value => $_, label => $_ } }
        sort keys %{ $self->states }
    ];
}

__PACKAGE__->meta->make_immutable;

1;

__DATA__
AL:ALABAMA
AK:ALASKA
AS:AMERICAN SAMOA
AZ:ARIZONA
AR:ARKANSAS
CA:CALIFORNIA
CO:COLORADO
CT:CONNECTICUT
DE:DELAWARE
DC:DISTRICT OF COLUMBIA
FM:FEDERATED STATES OF MICRONESIA
FL:FLORIDA
GA:GEORGIA
GU:GUAM
HI:HAWAII
ID:IDAHO
IL:ILLINOIS
IN:INDIANA
IA:IOWA
KS:KANSAS
KY:KENTUCKY
LA:LOUISIANA
ME:MAINE
MH:MARSHALL ISLANDS
MD:MARYLAND
MA:MASSACHUSETTS
MI:MICHIGAN
MN:MINNESOTA
MS:MISSISSIPPI
MO:MISSOURI
MT:MONTANA
NE:NEBRASKA
NV:NEVADA
NH:NEW HAMPSHIRE
NJ:NEW JERSEY
NM:NEW MEXICO
NY:NEW YORK
NC:NORTH CAROLINA
ND:NORTH DAKOTA
MP:NORTHERN MARIANA ISLANDS
OH:OHIO
OK:OKLAHOMA
OR:OREGON
PW:PALAU
PA:PENNSYLVANIA
PR:PUERTO RICO
RI:RHODE ISLAND
SC:SOUTH CAROLINA
SD:SOUTH DAKOTA
TN:TENNESSEE
TX:TEXAS
UT:UTAH
VT:VERMONT
VI:VIRGIN ISLANDS
VA:VIRGINIA
WA:WASHINGTON
WV:WEST VIRGINIA
WI:WISCONSIN
WY:WYOMING
