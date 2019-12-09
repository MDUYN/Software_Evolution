module series2::Server

import Content;
import util::Webserver;


public void serveValue(loc url, value v) {
	serve(url, Response (Request r) {
			return jsonResponse(ok(), ("content-type": "application/json", "Access-Control-Allow-Origin": "*"), v);
		});
}

public void restart(loc url, value v) {
	shutdown(url);
	serveValue(url, v);
}