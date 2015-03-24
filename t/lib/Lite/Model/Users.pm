package Lite::Model::Users;
use Mojo::Base 'MojoX::Model';

sub check {
  my ($self, $name) = @_;

  my $allow = grep { $_ eq $name } @{$self->app->defaults('users')};
  return $allow;
}

sub name {
  return $_[1] // 'name';
}

1;
