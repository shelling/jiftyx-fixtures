package JiftyTest;

use File::Basename;
use Cwd 'abs_path';

$ENV{'JIFTY_APP_ROOT'} = dirname( abs_path(__FILE__) ) . "/JiftyTest";
$ENV{'JIFTY_APP_ROOT'} = "/Users/shelling/develope/perl/JiftyX-Fixtures/t/lib/JiftyTest";

sub start {
  Jifty->web->add_javascript("main.js");
}

1;
