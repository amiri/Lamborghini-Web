use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Lamborghini::Web' }
BEGIN { use_ok 'Lamborghini::Web::Controller::Submission' }

ok( request('/submission')->is_success, 'Request should succeed' );
done_testing();
