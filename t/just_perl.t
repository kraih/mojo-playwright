use Mojo::Base -strict;

use Test::More;
use Test::Mojo;
use Mojo::File qw(curfile);

my $t = Test::Mojo->new(curfile->dirname->sibling('chat.pl'));

subtest 'Dashboard' => sub {
  $t->get_ok('/')->status_is(200)->text_is('title', 'Welcome');
};

subtest 'Chat' => sub {
  $t->get_ok('/chat')->status_is(200)->text_is('title', 'Chat');
};

done_testing;
