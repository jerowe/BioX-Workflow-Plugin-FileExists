package BioX::Workflow::Plugin::FileExists;

use strict;

use 5.008_005;
our $VERSION = '0.03';

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
[ -f "$input"  ] || \\{>&2 echo "INPUT: $input not found" ; exit 256; \\} && \\
[ -s "$input"  ] || \\{>&2 echo "INPUT: $input is empty";  \\} && \\
touch $input || {>&2 echo "INPUT: $input could not be touched. Please check your file permissions!"; exit 1;\\} && \\
touch $output || {>&2 echo "OUTPUT: $output could not be touched. Please check your file permissions!"; exit 1;\\} && \\
EOF
        $tprocess .= $process;
        $process = $tprocess;
    }
    if($output){
        $tprocess =<<EOF;
[ -f "$output"  ] || \\{>&2 echo "OUTPUT $output not found" ;  \\} && \\
[ -s "$output"  ] || \\{>&2 echo "OUTPUT $output is empty"; \\}
EOF
        $process .= $tprocess;
    }
    $self->process($process);

};

1;
__END__

=encoding utf-8

=head1 NAME

BioX::Workflow::Plugin::FileExists - a plugin to BioX::Workflow

=head1 SYNOPSIS

  biox-workflow.pl --plugins FileExists

=head1 DESCRIPTION

BioX::Workflow::Plugin::FileExists is a plugin of BioX::Workflow that first checks that your local INPUT exists.
If it doesn't exist it will exit with 256.
If INPUT is empty it will give a warning.
If OUTPUT is empty or doesn't exist it will give a warning.


=head1 AUTHOR

Jillian Rowe E<lt>jillian.e.rowe@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2016- Jillian Rowe

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
