use Mojo::Base -strict;

use Mojo::Server::Daemon;
use Mojo::File qw(curfile);

my $daemon = Mojo::Server::Daemon->new(listen => ['http://*?fd=3']);
$daemon->load_app(curfile->dirname->dirname->sibling('chat.pl'));

$daemon->app->config->{titles}{dashboard} = 'Bye';
#
# Here you can customize the app further (database, fixtures...)
#
$daemon->run;
#
# Here you can place cleanup code (drop database schema, delete files...)
#
