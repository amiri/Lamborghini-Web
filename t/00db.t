use Lamborghini::Testing;

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

my $tolga;
lives_ok {
    $tolga = $schema->resultset('User')->create(
        {   email      => 'tolgaonuk@gmail.com',
            first_name => 'Tolga',
            last_name  => 'Onuk',
            password => 't0lg@',
            city => 'Los Angeles',
            state => 'CA',
            zip => '90019',
            street_address => 'Stuff and Stuff Place #4',
            why => 'Cuz Im cool',
            phone => '1234567',
            dob => DateTime->now,
        },
    );
}
"Created user Tolga";

lives_ok { $tolga->add_to_roles($schema->resultset('Role')->all) } "Added Tolga as user and admin";

done_testing;
