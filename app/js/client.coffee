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

    send: (options) ->

        if "#{@module}/#{@method}" isnt 'empire/login'

            @sessionId ?= YAHOO.lacuna.Game.GetSession()

            if _.isArray options.params
                options.params = [@sessionId].concat options.params
            else if _.isObject options.params
                options.params['session_id'] = @sessionId

        # This is the jsonrpc 2.0 data that'll get sent to the server.
        data =
            jsonrpc: '2.0'
            id: 1
            method: @method
            params: options.params || []

        # These are the options passed into `http.request`
        requestOptions =
            method: 'POST'
            port: 80
            headers:
                'Content-Type': 'application/json'

        # Call `url.parse` and put it into the request options
        sendUrl = url.resolve YAHOO.lacuna.Game.RPCBase, @url
        _.assign requestOptions, url.parse sendUrl

        console.log 'Sending ', data.params, 'to', requestOptions.href

        # Now that we've sorted all that `params` stuff out. Let's send the request!
        req = http.request requestOptions, (res) ->
            res.setEncoding 'utf8'
            str = ''
            res.on 'data', (chunk) ->
                str += chunk

            res.on 'end', ->
                data = $.parseJSON str

                if data.result and options.success
                    options.success.call data.scope, data.result
                else if data.error and options.error
                    options.error.call data.scope, data.error
                else
                    console.log data, options
                    throw new Error 'Unknown options passed into Client.send()'

        req.on 'error', (err) ->
            # This will be a HTTP error (404, for example) not an in-game error.
            # As such, I don't really have anything smart to do here.
            console.log 'HTTP error...'
            console.log err

        # Write in the data that needs to be sent off.
        # TODO: this should use either `json2` or `jquery-json` to work properly
        #   in older browsers.
        req.write JSON.stringify data

        # Start the request.
        req.end()


# Initialize all of the methods that belong in the `Client` using the `modules` object.
# TODO: document this properly!
methods = {}

save = (path, url, methodList) ->
    _.each methodList, (method) ->
        sendFunc = _.bind Client::send, {url, method}
        util.deepSet(methods, "#{path}.#{method}", sendFunc)

func = (value, key) ->

    if value.url? and value.methods? and value.path?
        save(value.path, value.url, value.methods)

    if _.isObject value
        _.each value, func


_.each modules, func
_.assign(Client::, methods)

# Test the stuffs
Client::Empire.get_status
    params: []
    scope: @
    success: (result) ->
        console.log 'success'
    error: (error) ->
        console.log 'error'


module.exports = new Client()
