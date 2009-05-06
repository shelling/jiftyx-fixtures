package JiftyX::Fixtures::Script::Init;
# ABSTRACT: init subcommand

use warnings;
use strict;

use Jifty;
use Jifty::Everything;

use File::Basename;
use File::Spec;
use YAML qw(Dump LoadFile);

use base qw(
  App::CLI::Command
);

my $super = 'JiftyX::Fixtures::Script';

our $help_msg = qq{
Usage:

  jiftyx-fixtures init [options]

Options:

  -h, --help:               show help

};

sub options {
  my ($self) = @_;
  return (
    $super->options,
  );
}

sub before_run {
  my ($self) = @_;

  $super->before_run($self);

  return;
}

sub run {
  my ($self) = @_;
  $self->before_run();
  
  unless ($self->{config}->{fixtures}) {
    print "init...";
  }
}


1;
