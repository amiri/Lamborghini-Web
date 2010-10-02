package Lamborghini::Web::Controller::Login;

use Moose;
use Devel::Dwarn;
use namespace::autoclean;
use aliased "Lamborghini::Forms::LoginForm";

BEGIN { extends 'Catalyst::Controller'; }

sub index : Chained('/') PathPart('login') Args('0') {
    my ( $self, $c ) = @_;
    my $form = LoginForm->new;
    $c->stash( form => $form, template => 'login.tt2' );
    $form->process( params => $c->req->params, );
    $c->stash( fillinform => $form->fif );
    return unless $form->validated;
    if ( lc $c->req->method eq 'post' ) {
        my $email    = $c->req->params->{email};
        my $password = $c->req->params->{password};

        if ( $c->authenticate( { email => $email, password => $password } ) )
        {
            $c->flash(
                status_msg => "Welcome back, " . $c->user->first_name );
            return $c->res->redirect(
                $c->uri_for( $c->controller('Admin')->action_for('index') ) );
        }
        else {
            $c->stash( error_msg => "Bad username or password." );
        }
    }
    $c->stash( template => 'login.tt2' );
}

__PACKAGE__->meta->make_immutable;

1;
