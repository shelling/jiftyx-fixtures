use lib qw(lib t/lib);
use Test::More "no_plan";
use JiftyX::Fixtures;

BEGIN {
  use_ok "JiftyTest";
  require_ok "JiftyTest";
}

is(Jifty::Util->app_root, "/Users/shelling/develope/perl/JiftyX-Fixtures/t/lib/JiftyTest", Jifty::Util->app_root);

