#!/usr/bin/env perl

package Main;

use Moose;

extends 'BioX::Workflow';

my $app = Main->new_with_options;
$app->load_plugin('FileDetails');
$app->run();

1;
