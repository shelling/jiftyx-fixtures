package JiftyX::Fixtures::Script::Scaffold;
# ABSTRACT: scaffold subcommands

use warnings;
use strict;

use Jifty;
use Jifty::Everything;

use IO::File;
use File::Spec;
use File::Basename;
use YAML qw(Dump LoadFile);

use base qw(
  App::CLI::Command
);

my $super = 'JiftyX::Fixtures::Script';

sub options {
  my ($self) = @_;
  (
    $super->options,
    'e|environment=s' => "environment",
  );
}

sub before_run {
  my ($self) = @_;

  $super->run;

  $self->{environment} ||= "development";

  return;
}

sub run {
  my ($self, $args) = @_;
  $self->before_run();

  Jifty->new;

  for my $model ($self->model_list) {
    # my %columns =  map { $_->name() => undef } Jifty->app_class("Model",$model)->columns;

    my $filename = $self->fixtures_filename($model, "yml");
    my $file = IO::File->new ;
    if (defined $file->open("> $filename") ) {
      print $file "-\n";
      for my $c (Jifty->app_class("Model",$model)->columns) {
        print $file "  " . $c->name . ":\n" if $c->{writable};
      }
      $file->close;
    }

  }

}

sub model_list {
  my ($self) = @_;
  my @result =  map { basename($_) } glob(
    File::Spec->catfile(
      $self->{config}->{app_root},
      "lib",
      $self->{config}->{framework}->{ApplicationClass},
      "Model",
      "*"
    )
  );
  for (@result) {
    $_ =~ s/\.pm//g;
  }
  @result;
}

sub fixtures_filename {
  my ($self, $model, $format) = @_;
  return File::Spec->catfile(
      $self->{config}->{app_root},
      $self->{config}->{fixtures}->{$self->{environment}}->{dir},
      "$model.$format"
  );
}


1;
