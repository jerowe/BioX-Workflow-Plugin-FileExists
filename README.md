# NAME

BioX::Workflow::Plugin::FileExists - a plugin to BioX::Workflow

# SYNOPSIS

    biox-workflow.pl --plugins FileExists

# DESCRIPTION

BioX::Workflow::Plugin::FileExists is a plugin of BioX::Workflow that first checks that your local INPUT exists.
If it doesn't exist it will exit with 256.
If INPUT is empty it will give a warning.
If OUTPUT is empty or doesn't exist it will give a warning.

# AUTHOR

Jillian Rowe <jillian.e.rowe@gmail.com>

# COPYRIGHT

Copyright 2016- Jillian Rowe

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO
