package Lamborghini::Web;

use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw/
    -Debug
    Authentication
    Authorization::Roles
    ConfigLoader
    I18N
    Session
    Session::State::Cookie
    Session::Store::DBIC
    StackTrace
    Static::Simple
    Unicode::Encoding
    /;

extends 'Catalyst';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

__PACKAGE__->config(
    name                                        => 'Lamborghini::Web',
    disable_component_resolution_regex_fallback => 1,
    default_view                                => 'TT',
    'View::TT'                                  => {
        TEMPLATE_EXTENSION => '.tt2',
        render_die         => 1,
        INCLUDE_PATH       => 'root/src',
        WRAPPER            => 'wrapper.tt2',
        ENCODING           => 'utf-8',
    },
    'View::Email' => {
        stash_key => 'email',
        default   => {
            content_type => 'text/plain',
            charset      => 'utf-8'
        },
        sender => {
            mailer      => 'SMTP',
            mailer_args => {
                Host => 'localhost',    # defaults to localhost
            }
        }
    },
    'Plugin::Session' => {
        dbic_class     => 'DB::Session',
        expires        => 3600,
        verify_address => 0,
        id_field       => 'id',
        cookie_name    => 'lamborghini_web_session',
        flash_to_stash => 1,
    },
    'Plugin::Authentication' => {
        use_session   => 1,
        default_realm => 'user',
        realms        => {
            user => {
                credential => {
                    class              => 'Password',
                    password_field     => 'password',
                    password_type      => 'self_check',
                    password_hash_type => 'SHA-1',
                },
                store => {
                    class         => 'DBIx::Class',
                    user_class    => 'DB::User',
                    role_relation => 'roles',
                    role_field    => 'role',
                },
            },
        },
    },
);

__PACKAGE__->setup();

1;
