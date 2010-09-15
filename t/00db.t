use Lamborghini::Testing;

use Data::Random qw/rand_words rand_enum/;

my $test = Lamborghini::Testing->new;

my $schema = $test->schema;

ok( $schema, 'got schema from test class ok' );

my @on_connect_do = (
    "PRAGMA foreign_keys = ON",
);

lives_ok { $schema->deploy(
    {   add_drop_table    => 1,
        quote_field_names => 1,
    }
) } "I can deploy the schema OK";

done_testing;
