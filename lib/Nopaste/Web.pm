package Nopaste::Web;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
	my $self = shift;
	my $r = $self->routes;
	$r->get('/')->to('root#index');
	$r->post('/')->to('root#post');
}

1;
