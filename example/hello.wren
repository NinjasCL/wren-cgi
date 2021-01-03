#!wren_cli
import "http" for Response, Request

Response.echo("
<!DOCTYPE html>
<html>
    <head>
        <title>Wren CGI</title>
    </head>
    <body>
        <h1>Hello Wren from CGI</h1>
        <ul>
")

var env = Request.all
env.keys.each{|key|
    Response.echo("<li>%(key): %(env[key])</li>")
}

Response.echo("
    </ul>
    </body>
</html>
")

Response.send()
