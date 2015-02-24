use Mojo::Base -strict;

use Mojolicious::Lite;
use Test::Mojo;
use Test::More;

use lib 't/lib';
plugin 'model';

app->defaults(users => ['u1', 'u2']);

get '/' => sub {
  my $c = shift;

  my $name = $c->req->param('name') // '';

  my $allow = $c->model('users')->check($name);
  $c->render(text => $allow ? "Hi $name!" : 'Hi');
};

my $t = Test::Mojo->new;
$t->get_ok('/?name=u1')->status_is(200)->content_is('Hi u1!');
$t->get_ok('/?name=qq')->status_is(200)->content_is('Hi');

done_testing;
