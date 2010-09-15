#!/usr/bin/env perl

use inc::Module::Install;
use Module::Install::Catalyst;

name 'Lamborghini-Web';
all_from 'lib/Lamborghini/Web.pm';


requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Request::Upload';
requires 'Catalyst::Runtime';
requires 'Config::General';
requires 'DBIx::Class';
requires 'DateTime';
requires 'Email::Valid';
requires 'File::MimeInfo::Magic';
requires 'List::MoreUtils';
requires 'Moose';
requires 'Moose';
requires 'Moose::Util::TypeConstraints';
requires 'MooseX::Types::Moose';
requires 'MooseX::Types::URI';
requires 'Net::DNS';
requires 'Net::Domain::TLD';
requires 'Regexp::Common';
requires 'namespace::autoclean';

test_requires 'Test::Moose';
test_requires 'Test::More';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
