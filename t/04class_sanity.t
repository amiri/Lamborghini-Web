use Lamborghini::Testing;

my @modules        = findallmod Lamborghini;
my @schema_modules = findallmod Lamborghini::Schema::Result;
my @form_modules   = findallmod Lamborghini::Forms;

my @type_check_methods = qw/
        LamborghiniDateTime
        LamborghiniEmail
        LamborghiniFirstname
        LamborghiniLastname
        LamborghiniObscenity
        LamborghiniPassword
    /;

for (@modules) {
    use_ok($_);
}

for (@schema_modules) {
    can_ok( $_, @type_check_methods );
}

for (@form_modules) {
    use_ok($_);
    can_ok( $_, @type_check_methods );
}

done_testing;
