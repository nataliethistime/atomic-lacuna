###
# Client
#
###

modules = require 'js/client/modules'
util = require 'js/util'

http = require 'http'
url = require 'url'


class Client

    ###
    # ## Client.send
    # Send stuff to the server.
    ###

    send: (params=[]) ->

        if "#{@module}/#{@method}" isnt 'empire/login'

            @sessionId ?= YAHOO.lacuna.Game.GetSession()

            if _.isObject params
                params['session_id'] = @sessionId
            else if _.isArray params
                params = [@sessionId].concat params

        # This is the jsonrpc 2.0 data that'll get sent to the server.
        data =
            jsonrpc: '2.0'
            id: 1
            method: @method
            params: params

        # These are the options passed into `http.request`
        requestOptions =
            method: 'POST'
            port: 80
            headers:
                'Content-Type': 'application/json'

        # Call `url.parse` and put it into the request options
        sendUrl = url.resolve YAHOO.lacuna.Game.RPCBase, @url
        _.assign requestOptions, url.parse sendUrl

        # Now that we've sorted all that `params` stuff out. Let's send the request!
        req = http.request requestOptions, (res) ->
            # Success!
            console.log res

        req.on 'error', (err) ->
            console.log err

        # Write in the data that needs to be sent off and send the request.
        req.write JSON.stringify data
        req.end()


# Initialize all of the methods that belong in the `Client` using the `modules` object.
# TODO: document this properly!
methods = {}

save = (path, url, methodList, module) ->
    _.each methodList, (method) ->
        sendFunc = _.bind Client::send, {url, method, module}
        fullPath = "#{path}.#{method}"
        util.deepSet(methods, fullPath, sendFunc)

func = (value, key) ->

    if value.url? and value.methods? and value.path?
        save(value.path, value.url, value.methods, key)

    if _.isObject value
        _.each value, func


_.each modules, func
_.assign(Client::, methods)

# Test the stuffs
Client::Empire.get_status()


module.exports = new Client()
