package BioX::Workflow::Plugin::FileDetails;

our $VERSION = '0.01';

use Moose::Role;


after 'write_process' => sub {
    my $self = shift;

    my $cmd = "filedetails.pl --check_dir ".$self->outdir;
    print <<EOF;

#
# Starting FileDetails Plugin
#

EOF
    print "\n";
    print "filedetails.pl --check_dir ".$self->outdir;
    print "\n\n";
    print "wait\n";
    print <<EOF;

#
# Ending FileDetails Plugin
#

EOF
};

1;
__END__

=encoding utf-8

=head1 NAME

BioX::Workflow::Plugin::FileDetails - Blah blah blah

=head1 SYNOPSIS

  use BioX::Workflow::Plugin::FileDetails;

=head1 DESCRIPTION

BioX::Workflow::Plugin::FileDetails is

=head1 AUTHOR

Jillian Rowe E<lt>jillian.e.rowe@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2015- Jillian Rowe

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
