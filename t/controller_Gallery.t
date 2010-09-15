use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Lamborghini::Web' }
BEGIN { use_ok 'Lamborghini::Web::Controller::Gallery' }

ok( request('/gallery')->is_success, 'Request should succeed' );
done_testing();
