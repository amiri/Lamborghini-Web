#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use local::lib 'extlib';
use Lamborghini::Web;

Lamborghini::Web->setup_engine('PSGI');
my $app = sub { Lamborghini::Web->run(@_) };

