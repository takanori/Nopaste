package Nopaste::Web::Root;
use Mojo::Base 'Mojolicious::Controller';
use FormValidator::Lite;
use HTML::FillInForm::Lite;

sub index {
	my $self = shift;
	$self->render();
}

sub post {
	my $self = shift;
	my $validator = FormValidator::Lite->new($self->req);
	
	# エラーメッセージを設定
	$validator->set_message(
		'title.not_null' => 'Title is Empty',
		'body.not_null' => 'Body is Empty',
	);
	# 入力値チェック
	my $res = $validator->check(
		title => [qw/NOT_NULL/],
		body => [qw/NOT_NULL/],
	);
	# もし入力値が正しくなかったら
	if ($validator->has_error) {
		my @messages = $validator->get_error_messages;
		$self->stash->{error_messages} = \@messages;
		# 入力された値を充填しながら，描画
		my $html = $self->render('root/index', partial => 1)->to_string;
		return $self->render(
			text => HTML::FillInForm::Lite->fill(\$html, $self->req->params),
			format => 'html',
		);
	}
	# 入力値の妥当性が保証された
	# 続きはまた後で
}

1;