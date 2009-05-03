use lib qw(lib t/lib);
use Test::More "no_plan";
use Cwd 'abs_path';
use File::Basename;
use JiftyX::Fixtures;

BEGIN {
  use_ok "JiftyTest";
  require_ok "JiftyTest";
}

my $j = JiftyX::Fixtures->new(
  execution => {
    environment       => "test",
    'drop-database'   => "true",
  }
);

is($j->app_root, abs_path( dirname(__FILE__) ), $j->app_root);

is($j->config("fixtures")->{test}->{dir}, "/etc/fixtures/test");

is($j->config("framework")->{Database}->{Database}, "jiftytest");
is($j->config("framework")->{Database}->{Driver}, "SQLite");

is($j->config("execution")->{environment}, "test");
