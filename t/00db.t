use Lamborghini::Testing;

use Data::Random qw/rand_words rand_enum/;

my $test = Lamborghini::Testing->new;

my $schema = $test->schema;

ok( $schema, 'got schema from test class ok' );

my @on_connect_do = ( "PRAGMA foreign_keys = ON", );

lives_ok {
    $schema->deploy(
        {   add_drop_table    => 1,
            quote_field_names => 1,
        }
    );
}
"I can deploy the schema OK";

lives_ok {
    $schema->resultset('Role')
        ->create( { role => 'user' }, { role => 'admin' }, );
}
"Create roles for user and admin";

lives_ok {
    $schema->resultset('User')->create(
        {   email      => 'tolgaonuk@gmail.com',
            first_name => 'Tolga',
            last_name  => 'Onuk',
        },
    );
}
"Created user Tolga";

done_testing;
