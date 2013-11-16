# deck.coffee
#
# Starts an HTTP server on port 8888 that is used to
# serve up the assets under the web folder.
#
# TODO
# - a special URL to access code snippets for the client

port = 8888

express = require "express"
open = require "open"

app = express()

app.set "views", "#{__dirname}/views"
app.set "view engine", "jade"

app.use express.logger()

app.use express.bodyParser()
app.use express.methodOverride()

app.use app.router

app.use express.static "public"
app.use express.directory "public"

app.use (err, req, res, next) ->

  console.log err

  console.error 500, "There was a server-side failure."

  res.send 500, "There was a server-side failure."

app.get "/", (req, res) ->

   res.render "slides", (err, html) ->

      throw err if err

      res.render "deck-wrapper", slides: html

app.listen port

console.log "Express listening on port #{port}"

# Occasional problems with Chrome, so prefer FireFox
open "http://localhost:#{port}", "firefox"



