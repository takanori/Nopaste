package Nopaste::Web;
use Mojo::Base 'Mojolicious';
use Nopaste::DB;
require Nopaste::DB;

# This method will run once at server start
sub startup {
	my $self = shift;
	
	$self->plugin('PODRenderer');
	
	my $config = $self->plugin('Config', { file => 'nopaste.conf' });
	$self->attr(db => sub { Nopaste::DB->new($config->{db}) });
	
	# Initialize router
	my $r = $self->routes;
	
	# Set the namespace of controller
	$self->secret('Nopaste', $config->{secret});

	$r->get('/')->to('root#index');
	$r->post('/')->to('root#post');
	
	$r->route('/paste/:id')->to('root#entry');
	
	$r->route('/docs/about')->to('docs#about');
	$r->route('/docs/privacy')->to('docs#privacy');

}

1;
