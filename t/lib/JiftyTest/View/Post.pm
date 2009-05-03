package JiftyTest::View::Post;
use warnings;
use strict;
use Jifty::View::Declare -base;
use Jifty::View::Declare::Helpers;
use base qw/ Jifty::View::Declare::CRUD /;

use JiftyX::ModelHelpers;

template "view" => page {
  div { "crud view " }
};

template "list" => page {
  div {
    "post list"
  }
};

1;
