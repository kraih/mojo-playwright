use Mojolicious::Lite -signatures;
use Mojo::EventEmitter;

helper events => sub { state $events = Mojo::EventEmitter->new };

app->config(titles => {dashboard => 'Welcome', chat => 'Chat'});

get '/' => {template => 'index'};

get '/chat' => {template => 'chat'};

websocket '/channel' => sub ($c) {
  $c->inactivity_timeout(3600);

  # Forward messages from the browser
  $c->on(message => sub ($c, $message) { $c->events->emit(mojochat => $message) });

  # Forward messages to the browser
  my $cb = $c->events->on(mojochat => sub ($events, $message) { $c->send($message) });
  $c->on(finish => sub ($c, $code, $reason) { $c->events->unsubscribe(mojochat => $cb) });
};

app->start;
__DATA__
@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body>
    %= content
  </body>
</html>

@@ index.html.ep
% layout 'default', title => config->{titles}{dashboard};
<%= link_to Chat => 'chat' %>

@@ chat.html.ep
% layout 'default', title => config->{titles}{chat};
<form onsubmit="sendChat(this.children[0]); return false">
  <input type="text">
  <input type="submit" value="Send">
</form>
<div id="messages"></div>
<script>
  var ws  = new WebSocket('<%= url_for('channel')->to_abs %>');
  ws.onmessage = function (e) {
    document.getElementById('messages').innerHTML += '<p>' + e.data + '</p>';
  };
  function sendChat(input) { ws.send(input.value); input.value = '' }
</script>
