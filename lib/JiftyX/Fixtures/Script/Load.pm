package JiftyX::Fixtures::Script::Load;
use warnings;
use strict;

use Jifty;
use Jifty::Everything;

use File::Basename;
use File::Spec;
use YAML qw(Dump LoadFile);

use base qw(
  JiftyX::Fixtures::Script::Base
  App::CLI::Command
);

sub options {
  my ($self) = @_;
  return (
    $self->SUPER::options,
    'd|drop-database=s' => 'drop-database',
    'e|environment=s'   => 'environment',
  );
}

sub fixtures_files {
  my $self = shift;
  glob(
    File::Spec->catfile(
      $self->{config}->{app_root},
      "etc",
      "fixtures",
      $self->{environment},
      "*"
    )
  );
}

sub drop_db {
  my $self = shift;
  my $dbconfig = $self->{config}->{framework}->{Database};

  if ( $dbconfig->{Driver} eq "SQLite" && -e $dbconfig->{Database} ) {
    print "WARN - SQLite Database has existed, delete file now.\n";
    unlink $dbconfig->{Database};
  }

  if ($dbconfig->{Driver} eq "MySQL") {
    print "WARN - MySQL Database has existed, delete file now.\n";
    unlink $dbconfig->{Database};
    my $dbh = DBI->connect("dbi:mysql:database=".$dbconfig->{Database}, $dbconfig->{User}, $dbconfig->{Password});
    $dbh->prepare("drop database ". $dbconfig->{Database});
    $dbh->disconnect;
  }
}

sub run {
  my ($self) = @_;

  if ($self->{help}) {
    print qq{
jiftyx-fixtures v$JiftyX::Fixtures::VERSION

Usage:

  jiftyx-fixtures load [options]

Options:

  --drop-database:    [-d] drop database before loading fixtures, default is true
  --environment:      [-e] specify environment, default is development
  --help:             [-h] show help
    \n};
    return;
  }

  $self->{environment} ||= "development";
  $self->{'drop-database'} ||= "true";

  $self->drop_db if ($self->{"drop-database"} eq "true");

  eval qq{
    package main;
    Jifty->new;
  };

  for ($self->fixtures_files) {
    my $filename = basename($_);
    $filename =~ s/\.yml//;

    my $fixtures = LoadFile($_);

    my $model = Jifty->app_class("Model",$filename)->new;

    for my $entity (@{ $fixtures }) {
      $model->create( %{$entity} );
    }
  }
}


1;
