#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use Template;
use Template::Provider::FromDATA;
use Carp;
use File::Spec;
use Cwd 'abs_path';
use Moose;
use MooseX::Types::Path::Class;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Lamborghini::Schema;
use List::MoreUtils qw/any/;

with 'MooseX::Getopt';

has 'origin' => (
    is       => 'rw',
    isa      => 'Path::Class::Dir',
    required => 1,
    coerce   => 1,
    default  => "$FindBin::Bin/../lib/Lamborghini/Schema/Result",
);

has 'destination' => (
    is       => 'rw',
    isa      => 'Path::Class::Dir',
    required => 1,
    coerce   => 1,
    default  => "$FindBin::Bin/../lib/Lamborghini/Web/Controller/Admin",
);

has 'app' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
    default  => 'Lamborghini::Web',
);

my $schema = Lamborghini::Schema->connect(
    'dbi:Pg:dbname=Lamborghini',
    'postgres',
    '',
    {   pg_enable_utf8 => 1,
        autocommit     => 1,
        quote_char     => q/"/,
        name_sep       => q/./,
    }
);

sub run {
    my ($self) = @_;
    my $provider
        = Template::Provider::FromDATA->new( { CLASSES => __PACKAGE__ } );

    for my $child ( $self->origin->children ) {
        next if $child =~ /\.svn/;
        next if $child =~ /Session|GreenPrepTip/;
        ( my $filename   = $child )    =~ s/^.*\///g;
        ( my $modulename = $filename ) =~ s/\.pm//g;

        my $controller = Template->new( { LOAD_TEMPLATES => [$provider] } );
        my $formname = $modulename . 'Form';

        print STDERR "Modulename: $modulename\n";
        my $rs = $schema->resultset($modulename);

        ### Construct create_related lines
        my %has_many
            = map { $_, $rs->result_source->relationship_info($_) } grep {
            $rs->result_source->relationship_info($_)->{attrs}->{accessor} eq
                'multi'
            } $rs->result_source->relationships;

        my ($has_many) = keys(%has_many);
        my $related_items;
        if ($has_many) {
            my $obj = lc($modulename);
            $related_items = "related_items => [
                \@{ [ \$c->stash->{$obj}->${has_many} ] }
            ]";

        }

        ### Construct param switch for file uploads
        my ($edit_param_switch, $create_param_switch,
            $new_result,        $form_declaration
        );

#print STDERR $rs->result_source->source_name, " needs param switching\n" if any {/file|icon/} $rs->result_source->columns;
        print STDERR $rs->result_source->source_name,
            " needs param switching\n"
            if any {/file|qqfile/} $rs->result_source->columns;

        if ( any {/file/} $rs->result_source->columns ) {
            $edit_param_switch
                = "\$c->req->params->{file} = \$c->req->upload('file');";
            $create_param_switch
                = "if (lc \$c->req->method eq 'post') {\n\t\t\$c->req->params->{file} = \$c->req->upload('file');\n\t\t\$c->req->params->{qqfile} = \$c->req->upload('qqfile');\n\t}";
            $new_result       = "author => \$c->user->id";
            $form_declaration = $formname
                . "->new(\n\t\timage_dir => \$c->path_to( \$c->config->{'Model::Image::Validate'}->{user_image_dir} ),\n\t\tthumb_dir => \$c->path_to( \$c->config->{'Model::Image::Validate'}->{thumb_image_dir} ),\n\t\tvideo_dir => \$c->path_to( \$c->config->{'Model::Video::Validate'}->{user_video_dir} ),\n\t);";
        }

#elsif (any {/icon/} $rs->result_source->columns) {
#$edit_param_switch = "\$c->req->params->{icon} = \$c->req->upload('icon');";
#$create_param_switch = "if (lc \$c->req->method eq 'post') {\n\t\t\$c->req->params->{icon} = \$c->req->upload('icon');\n\t}";
#$new_result = "";
#$form_declaration = "\$c->stash->{form};";
#}
        else {
            $edit_param_switch   = "\n";
            $create_param_switch = "\n";
            $new_result          = "";
            $form_declaration    = "\$c->stash->{form};";
        }

        my $controllerpath = abs_path(
            File::Spec->catfile( $self->destination, $filename ) );

        print "Controller file: $controllerpath\n";

        my %data = (
            app                 => $self->app,
            modulename          => $modulename,
            formname            => $formname,
            class               => lc($modulename),
            related_items       => $related_items,
            edit_param_switch   => $edit_param_switch,
            create_param_switch => $create_param_switch,
            new_result          => $new_result,
            form_declaration    => $form_declaration,
        );

        $controller->process( 'controller', \%data, $controllerpath )
            or die $controller->error;

    }

}

__PACKAGE__->meta->make_immutable;
__PACKAGE__->new_with_options->run unless caller;

1;

__DATA__

__controller__
package [% app %]::Controller::Admin::[% modulename %];

use Moose;
use DBIx::Class::ResultClass::HashRefInflator;
use namespace::autoclean;
use aliased 'Lamborghini::Forms::[% formname %]';

BEGIN { extends qw/Lamborghini::Web::Controller::Admin/; }

with 'Lamborghini::Web::ControllerRole::CRUD';

__PACKAGE__->config(
    model_name => 'DB::[% modulename %]',
    class      => '[% modulename %]',
    item_name  => '[% class %]',
    form       => 'Lamborghini::Forms::[% formname %]',
    actions    => {
        base => {
            PathPart    => ['[% class %]'],
            Chained     => ['admin_base'],
            CaptureArgs => 0
        }
    },
);

__PACKAGE__->meta->make_immutable;

1;
