use Mojo::Base -strict;

use Mojolicious::Lite;
use Test::Mojo;
use Test::More;

use lib 't/lib';
plugin Model => {namespace => 'Lite::Model'};

get '/' => sub {
  my $c = shift;

  $c->render(text => $c->model('users')->name());
};

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200)->content_is('name');

done_testing;
