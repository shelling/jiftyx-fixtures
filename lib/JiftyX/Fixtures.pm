package JiftyX::Fixtures;
# ABSTRACT: Insert fixtures into your Jifty application database

use strict;
use warnings;

use Jifty;
use Jifty::Everything;
use Jifty::Util;

use YAML qw(Dump LoadFile);

use JiftyX::Fixtures::Script;

sub new {
  my $self = bless {}, shift;

  $self->{config}->{app_root} = Jifty::Util->app_root;
  $self->{config}->{framework}  = Jifty->config->stash->{framework};
  $self->{config}->{fixtures}   = LoadFile( $self->{config}->{app_root} . "/etc/fixtures.yml");

  $self;
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

sub run { 
  my $self = shift;
  JiftyX::Fixtures::Script->dispatch( config => $self->{config} );
}
  

1;

=head1 SYNOPSIS


=head1 DESCRIPTION


=head1 METHODS


=head2 new

Constructor, invoke without args

=head2 config

Give one arg which is selected from "app_root", "framework", "fixtures", "execution" to get the configuration detail.

Append second arg to set the configuration.

    $jf->config("fixtures"); #=> [  development => { dir => "etc/fixtures/development" }, 
                                    test => { dir => "etc/fixtures/test" } ]
    $jf->config(
      fixtures => [
        development => {
          dir => "etc/dev_fixtures"
        },
        test => {
          dir => "etc/test_fixtures"
        }
      ]
    );

=head2 run

Running script

