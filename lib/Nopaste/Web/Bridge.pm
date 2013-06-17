package Nopaste::Web::Bridge;
use Mojo::Base 'Mojolicious::Controller';

# Bridge for pre-procsssing
sub login_check {
	my $self = shift;

	# Add the HTTP header for JavaScript access.
	$self->res->header->add('Access-Control-Allow-Origin', '*');

	# Set the expiration time for session cookie
	$self->session(expiration => 604800);

	# Reset the User session helper. (state of the quest session)
	$self->app->helper('ownUserId' => sub { return undef });
	$self->app->helper('ownUser' => sub { return undef });
	$self->stash(logined => 0);

	# Check a session
	if ($self->session('session_token')) { # If user-agent has a session...
		# Find a matching user from the database
		my $iter = $self->app->db->single('entry', { id => $self->st

1;
