package JiftyX::Fixtures::Script;
# ABSTRACT: Main script package handling dispatch for subcommands

use strict;
use warnings;

use App::CLI;
use base qw(App::CLI App::CLI::Command);

sub options {
  return (
    'h|help|?'  => 'help',
    'man'     => 'man',
  );
}

sub before_run {
  my ($here, $self) = @_;

  if ($self->{help}) {
    print "jiftyx-fixtures v$JiftyX::Fixtures::VERSION\n";
    eval 'print $' . ref($self) . '::help_msg';
    exit;
  }

}

sub run {
  my ($here, $self) = @_;
}


1;
