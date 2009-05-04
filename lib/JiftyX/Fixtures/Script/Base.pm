package JiftyX::Fixtures::Script::Base;
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
