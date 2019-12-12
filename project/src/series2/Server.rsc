module series2::Server

import Content;
import util::Webserver;

import IO;

public void serveValue(loc url, value v) {
	serve(url, Response (Request r) {
			return jsonResponse(ok(), ("content-type": "application/json", "Access-Control-Allow-Origin": "*"), v);
		});
}

public void serveValues(loc url, map[str path, value json] values) {
	serve(url, Response (Request r) {
		println(r.path);
		if(r.path in values) {
			return jsonResponse(ok(), ("content-type": "application/json", "Access-Control-Allow-Origin": "*"), values[r.path]);
		} 
		return response(notFound(), "");
	});
}

public void restart(loc url, value v) {
	shutdown(url);
	serveValue(url, v);
}