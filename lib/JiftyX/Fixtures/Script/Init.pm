package JiftyX::Fixtures::Script::Init;
# ABSTRACT: init subcommand

use warnings;
use strict;

use Jifty;
use Jifty::Everything;

use IO::File;
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

my $prototype = qq{
development:
  dir: "etc/fixtures/development"
  format: "yml"
  greeking: "false"

test:
  dir: "etc/fixtures/test"
  format: "yml"
  greeking: "false"

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

    my $fixtures_config = IO::File->new;
    if ($fixtures_config->open("> " . $self->{config}->{app_root} . "/etc/fixtures.yml")) {
      print $fixtures_config $prototype;
    }

    mkdir $self->{config}->{app_root} . "/etc/fixtures";
  }
}

1;
