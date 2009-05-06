package JiftyX::Fixtures::Script::Help;
# ABSTRACT: help subcommands

use warnings;
use strict;

use base qw(
  App::CLI::Command::Help
);

sub run {
  my $self = shift;

  if ($self->{config}->{fixtures}) {
    $self->SUPER(@_);
  } else {
    print $self->{config}->{app_root} . " is not existed. Please run `jiftyx-fixtures init`\n";
  }

}



1;
