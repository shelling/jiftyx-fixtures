package JiftyX::Fixtures::Script;
# ABSTRACT: Main script package handling dispatch for subcommands

use strict;
use warnings;

use App::CLI;
use base qw(App::CLI App::CLI::Command);

sub options {
  my ($self) = caller;
  return (
    'h|help|?'  => 'help',
    'man'     => 'man',
  );
}

sub run {
  my ($self) = caller;
  print "INFO - run " . $self . "\n";
}


1;
