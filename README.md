[![Build Status](https://travis-ci.org/avkhozov/Mojolicious-Plugin-Model.svg?branch=master)](https://travis-ci.org/avkhozov/Mojolicious-Plugin-Model)
# NAME

Mojolicious::Plugin::Model - Model for Mojolicious applications

# SYNOPSIS

Model Users

    package MyApp::Model::Users;
    use Mojo::Base 'MojoX::Model';

    sub check {
      my ($self, $name, $pass) = @_;

      # Constant
      return int rand 2;

      # Or Mojo::Pg
      return $self->app->pg->db->query('...')->array->[0];

      # Or HTTP check
      return $self->app->ua->post($url => json => {user => $name, pass => $pass})
        ->rex->tx->json('/result');
    }

    1;

Model Users-Client

    package MyApp::Model::Users::Client;
    use Mojo::Base 'MyApp::Model::User';

    sub do {
      my ($self) = @_;
    }

    1;

Mojolicious::Lite application

    #!/usr/bin/env perl
    use Mojolicious::Lite;

    use lib 'lib';

    plugin 'Model';

    # /?user=sebastian&pass=secr3t
    any '/' => sub {
      my $c = shift;

      my $user = $c->param('user') || '';
      my $pass = $c->param('pass') || '';

      # client model
      my $client = $c->model('users-client');
      $client->do();

      return $c->render(text => "Welcome $user.") if $c->model('users')->check($user, $pass);
      $c->render(text => 'Wrong username or password.');
    };

    app->start;

# DESCRIPTION

[Mojolicious::Plugin::Model](https://metacpan.org/pod/Mojolicious::Plugin::Model) is a Model (M in MVC architecture) for Mojolicious applications. Each
model has an `app` attribute.

# OPTIONS

[Mojolicious::Plugin::Model](https://metacpan.org/pod/Mojolicious::Plugin::Model) supports the following options.

## namespaces

    # Mojolicious::Lite
    plugin Model => {namespaces => ['MyApp::Model']};

Namespace to load models from, defaults to `$moniker::Model`.

## base\_classes

    # Mojolicious::Lite
    plugin Model => {base_classes => ['MyApp::Model']};

Base classes used to identify models, defaults to [MojoX::Model](https://metacpan.org/pod/MojoX::Model).

## default

    # Mojolicious::Lite
    plugin Model => {default => 'MyModel'};

    any '/' => sub {
      my $c = shift();
      $c->model->do(); # used model MyModel
      # ...
    }

The name of the default model to use if the name of the current model not specified.

# HELPERS

[Mojolicious::Plugin::Model](https://metacpan.org/pod/Mojolicious::Plugin::Model) implements the following helpers.

## model

    my $model = $c->model('users');

Create and cache a model object with given name.

# METHODS

[Mojolicious::Plugin::Model](https://metacpan.org/pod/Mojolicious::Plugin::Model) inherits all methods from
[Mojolicious::Plugin](https://metacpan.org/pod/Mojolicious::Plugin) and implements the following new ones.

## register

    $plugin->register(Mojolicious->new);

Register plugin in [Mojolicious](https://metacpan.org/pod/Mojolicious) application.

# SEE ALSO

[Mojolicious](https://metacpan.org/pod/Mojolicious), [Mojolicious::Guides](https://metacpan.org/pod/Mojolicious::Guides), [http://mojolicio.us](http://mojolicio.us).

# AUTHOR

Andrey Khozov, `avkhozov@googlemail.com`.

# CREDITS

Denis Ibaev, `dionys@gmail.com`.

# COPYRIGHT AND LICENSE

Copyright (C) 2015, Andrey Khozov.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.
