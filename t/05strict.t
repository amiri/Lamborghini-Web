#!/usr/bin/env perl
use Test::More;
use Test::Perl::Critic;
use FindBin;
use File::Spec;

my $rcfile = File::Spec->catfile( 't', 'perlcriticrc' );
Test::Perl::Critic->import(
    -profile => $rcfile,
    -include => [ 'layout', 'documentation', 'bangs' ],
    -exclude => ['sections'],
);
all_critic_ok("$FindBin::Bin/../lib");
