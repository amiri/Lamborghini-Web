use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Lamborghini::Web' }
BEGIN { use_ok 'Lamborghini::Web::Controller::Submissions' }

ok( request('/submissions')->is_success, 'Request should succeed' );
done_testing();
