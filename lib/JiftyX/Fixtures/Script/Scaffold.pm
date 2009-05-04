package JiftyX::Fixtures::Script::Scaffold;
use warnings;
use strict;

use base qw(
  JiftyX::Fixtures::Script::Base
  App::CLI::Command
);

sub options {
  my ($self) = @_;
  (
    $self->SUPER::options,
  );
}

sub run {
  my ($self, $args) = @_;
  print "INFO - run " . ref($self) ."\n";
}

1;
