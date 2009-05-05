package JiftyX::Fixtures::Script::Scaffold;
# ABSTRACT: scaffold subcommands

use warnings;
use strict;

use Jifty;
use Jifty::Everything;

use File::Spec;
use File::Basename;
use YAML qw(Dump LoadFile);

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
  Jifty->new;

  my @models = map { basename($_) } glob(
    File::Spec->catfile(
      $self->{config}->{app_root},
      "lib",
      $self->{config}->{framework}->{ApplicationClass},
      "Model",
      "*"
    )
  );

  for my $model (@models) {
    $model =~ s/\.pm//g;
    my %columns =  map { $_->name() => "" } Jifty->app_class("Model",$model)->columns;
    print Dump [\%columns];
  }

}

1;
