package JiftyX::Fixtures;
# ABSTRACT: Insert fixtures into your Jifty application database

use strict;
use warnings;

use Jifty;
use Jifty::Everything;
use Jifty::Util;

use File::Basename;
use File::Spec;
use YAML qw(Dump LoadFile);

sub new {
  my $self = bless {}, shift;
  my %options = @_;

  $options{execution}{'drop-database'} = "true" unless defined($options{execution}{'drop-database'});
  $options{execution}{environment} = "development" unless defined($options{execution}{environment});

  $self->{app_root} = Jifty::Util->app_root;
  $self->{config}->{framework}  = Jifty->config->stash->{framework};
  $self->{config}->{fixtures}   = LoadFile( $self->{app_root} . "/etc/fixtures.yml");

  for (keys %options) {
    $self->{config}->{$_} = $options{$_};
  }

  if ($self->{config}->{execution}->{"drop-database"} eq "true") {
    my $dbconfig = $self->{config}->{framework}->{Database};

    if ($dbconfig->{Driver} eq "SQLite" && -e $dbconfig->{Database} ) {
      print "WARN - SQLite Database has existed, delete file now.\n";
      unlink $dbconfig->{Database};
    }

  }

  $self;
}

sub app_root { 
  my ($self, $args) = @_;
  if ($args) {
    $self->{app_root} = $args;
    $self;
  } else {
    $self->{app_root};
  }
}

sub config {
  my ($self, $type, $args) = @_;
  if ($args) {
    $self->{config}->{$type} = $args;
    $self;
  } else {
    $self->{config}->{$type};
  }
}

sub fixtures_files {
  my $self = shift;
  glob( File::Spec->catfile($self->app_root, "etc", "fixtures", $self->{config}->{execution}->{environment} , "*") );
}
  
sub run {
  my $self = shift;
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

=head1 SYNOPSIS


=head1 DESCRIPTION


=head1 METHODS


=head2 new


=head2 app_root

Invoke without args to get your application root.

Give one arg to set it.


=head2 config

Give one arg which is selected from "framework", "fixtures", "execution" to get the configuration detail.

Append second arg to set the configuration.

    $jf->config("fixtures"); #=> { development => { dir => "etc/fixtures/development" }, test => { dir => "etc/fixtures/test" } }
    $jf->config(
      fixtures => {
        development => {
          dir => "etc/dev_fixtures"
        },
        test => {
          dir => "etc/test_fixtures"
        }
      }
    );

=head2 fixtures_files


=head2 run



