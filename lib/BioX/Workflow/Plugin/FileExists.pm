package BioX::Workflow::Plugin::FileExists;

use strict;

use 5.008_005;
our $VERSION = '0.01';

use Data::Dumper;
use Data::Pairs;

use Moose::Role;

before 'write_process' => sub{
    my $self = shift;

    my $process = $self->process;
    chomp($process);
    $process = $process." && \\\n";
    my @input =  $self->local_attr->get_values('INPUT') if $self->local_attr->exists('INPUT');
    my @output =  $self->local_attr->get_values('OUTPUT') if $self->local_attr->exists('OUTPUT');

    my($input, $output) = ($input[0], $output[0]);

    my $tprocess = "";
    if($input){
        $tprocess .=<<EOF;
[ -f "$input"  ] || \\{ echo "INPUT $input not found" ; exit 256; \\} && \\
[ -s "$input"  ] || \\{ echo "INPUT $input is empty" ;  \\} && \\
EOF
        $tprocess .= $process;
        $process = $tprocess;
    }
    if($output){
        $tprocess =<<EOF;
[ -f "$output"  ] || \\{ echo "OUTPUT $output not found";  \\} && \\
[ -s "$output"  ] || \\{ echo "OUTPUT $output is empty"; \\}
EOF
        $process .= $tprocess;
    }
    $self->process($process);

    #print "Process!\n$process\n\n";
};

1;
__END__

=encoding utf-8

=head1 NAME

BioX::Workflow::Plugin::FileExists - Blah blah blah

=head1 SYNOPSIS

  use BioX::Workflow::Plugin::FileExists;

=head1 DESCRIPTION

BioX::Workflow::Plugin::FileExists is

=head1 AUTHOR

Jillian Rowe E<lt>jillian.e.rowe@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2016- Jillian Rowe

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
