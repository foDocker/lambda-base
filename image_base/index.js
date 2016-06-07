var MongoMQ		= require("mongomq").MongoMQ;
var context		= require("./lambda_context.json");
var lambda_function	= require("./lambda_function.js");

var queue = new MongoMQ({
	host		: "mongo",
	autoStart	: true
});

queue.once("lambda - request - " + context.name, function(error, newEvent) {
	console.log({error, data: newEvent});
	var hash = newEvent.hash;
	console.log("hash:", hash);
	var ret = function(error, data) {
		queue.emit("lambda - response - " + hash, data);
		queue.stop(process.exit.bind(process, 0));
	};
	if(!("name" in context)) ret("Lambda name not defined");
	lambda_function(newEvent.data, context, ret);
});
