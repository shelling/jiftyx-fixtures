package JiftyX::Fixtures::Script::Clean;
# ABSTRACT: clean subcommand

use warnings;
use strict;

use Jifty;
use Jifty::Everything;

use IO::File;
use File::Basename;
use File::Spec;
use File::Path;
use YAML qw(Dump LoadFile);

use base qw(
  App::CLI::Command
);

my $super = 'JiftyX::Fixtures::Script';

our $help_msg = qq{
Usage:

  jiftyx-fixtures clean [options]

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

  for (keys %{$self->{config}->{fixtures}}) {
    my $dir = File::Spec->catfile(
      $self->{config}->{app_root},
      $self->{config}->{fixtures}->{$_}->{dir}
    );
    rmtree $dir;
  }
  rmdir File::Spec->catfile(
    $self->{config}->{app_root},
    "etc",
    "fixtures"
  );
  unlink File::Spec->catfile(
    $self->{config}->{app_root},
    "etc",
    "fixtures.yml"
  );


}

1;
