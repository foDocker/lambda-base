echo 'db.queue.mapReduce(function(){emit(this.event.replace(/lambda - request - /, ""), 1)}, function(key, values){var count = 0; values.forEach(function(v){count += v}); return count}, {query: {event: /lambda - request - (\w+)/, handled: false}, out: {inline: 1}}).results' | mongo mongo/mongomq | grep "\[" | perl -MJSON -le 'my $events = from_json join "", <>; for my $event(@$events) {print "$event->{_id} => $event->{value}"}'
