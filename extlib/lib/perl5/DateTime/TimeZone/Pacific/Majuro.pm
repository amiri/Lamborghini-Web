# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/tjCMGdB1Ks/australasia.  Olson data version 2010m
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Pacific::Majuro;

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Pacific::Majuro::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
59958189312,
DateTime::TimeZone::NEG_INFINITY,
59958230400,
41088,
0,
'LMT'
    ],
    [
59958189312,
62127694800,
59958228912,
62127734400,
39600,
0,
'MHT'
    ],
    [
62127694800,
DateTime::TimeZone::INFINITY,
62127738000,
DateTime::TimeZone::INFINITY,
43200,
0,
'MHT'
    ],
];

sub olson_version { '2010m' }

sub has_dst_changes { 0 }

sub _max_year { 2020 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}



1;
