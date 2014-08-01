###
# Client
# This is the client Node-based client that should work better and be easier to
# work with than the included `YUI` client.
###

'use strict'

modules = require 'js/client/modules'
util = require 'js/util'

http = require 'https'
{parse, resolve} = require 'url'


class Session

    get: ->
        unless @sessionId
            @sessionId = YAHOO.lacuna.Game.GetSession()

        @sessionId


class Client

    prepareParams: (params) ->

        # Most requests use an array, so this should be fine.
        params ?= []

        if "#{@module}/#{@method}" isnt 'empire/login'

            sessionId = Session::get()

            if _.isArray params
                [sessionId].concat params
            else if _.isObject params
                params.session_id = sessionId
                params
        else
            params

    preparePostData: (params) ->
    # This is the jsonrpc 2.0 data that'll get sent to the server
        jsonrpc: '2.0'
        id: 1
        method: @method
        params: params

    prepareRequestOptions: (url) ->
        options =
            method: 'POST'
            port: 80
            headers:
                'Content-Type': 'application/json'

        # Call `url.parse` and put it into the request options
        sendUrl = resolve YAHOO.lacuna.Game.RPCBase, url
        _.assign options, parse sendUrl

        options

    ###
    # ## Client.send
    # Send stuff to the server.
    ###

    send: (options) ->
        console.log @

        data = @preparePostData @prepareParams options.params
        requestOptions = @prepareRequestOptions @url

        # This is a debug message but it may as well stay for a while.
        console.log 'Sending ', data.params, 'to', requestOptions.href

        # Now that we've sorted all that `params` stuff out. Let's send the request!
        req = http.request requestOptions, _.partialRight @handleRpcRes, options

        req.on 'error', _.partialRight @handleRpcErr, options

        # Write in the data that needs to be sent off.
        # TODO: this should use either `json2` or `jquery-json` to work properly
        #   in older browsers.
        req.write JSON.stringify data

        # Start the request.
        req.end()

    handleRpcRes: (res, options) ->
        res.setEncoding 'utf8'
        str = ''
        res.on 'data', (chunk) ->
            str += chunk

        res.on 'end', ->
            data = $.parseJSON str

            # The server returns a `result` block
            if data.result and options.success
                options.success.call data.scope, data.result
            else if data.error and options.error
                options.error.call data.scope, data.error
            else
                console.log data, options
                throw new Error 'Unrecognized options passed into Client.send()'

    handleRpcErr: (err, options) ->
        # This will be a HTTP error (404, for example) not an in-game error.
        # As such, I don't really have anything smart to do here.
        console.log 'HTTP error...'
        console.log err, options


# Initialize all of the methods that belong in the `Client` using the `modules` object.
# TODO: document this properly!
methods = {}

save = (path, url, methodList) ->
    _.each methodList, (method) ->
        sendFunc = _.bind Client::send, _.assign _.clone(Client::), {url, method}
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
        console.log result
    error: (error) ->
        console.log error
        console.log 'error'


module.exports = new Client()
