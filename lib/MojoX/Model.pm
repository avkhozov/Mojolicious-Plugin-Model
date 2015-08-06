package MojoX::Model;

use strict;
use warnings;

use Scalar::Util 'weaken';

use base 'Mojo::Base';

__PACKAGE__->attr(app => undef);

sub new {
  my $self = shift()->SUPER::new(@_);
  weaken($self->{app}) if ref($self->{app});
  return $self;
}

1;

__END__

=encoding utf8

=head1 NAME

MojoX::Model - Model base class

=head1 SYNOPSIS

  # Model
  package App::Model::Foo;
  use Mojo::Base 'MojoX::Model';

  sub do {
    # Do something.
  }

  # Application
  $self->model('Foo')->do();

=head1 DESCRIPTION

L<MojoX::Model> is the base class for your Mojolicious models.

=head1 ATTRIBUTES

L<MojoX::Model> inherits all attributes from L<Mojo::Base> and implements
the following new ones.

=head2 app

    my $app = $model->app;
    $model  = $model->app(Mojolicious->new);

A reference back to the application, usually a L<Mojolicious> object.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=head1 AUTHOR

Andrey Khozov, C<avkhozov@googlemail.com>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015, Andrey Khozov.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
