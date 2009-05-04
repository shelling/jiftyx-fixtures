package JiftyX::Fixtures::Script::Base;
# ABSTRACT: Base package of all subcommands, should not run it

use warnings;
use strict;

use base qw(
  App::CLI::Command
);

sub options {
  return (
    'h|help|?'  => 'help',
    'man'     => 'man',
  );
}

sub run {
  my ($self) = @_;
  print "run() does not defined in " . ref($self) . "\n";
}


1;
