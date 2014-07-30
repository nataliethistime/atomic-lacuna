###
# Client
#
###

modules = require 'js/client/modules'
util = require 'js/util'

request = require 'superagent'
{resolve} = require 'url'


class Client

    ###
    # ## Client.send
    # Send stuff to the server.
    ###

    send: (params=[]) ->
        console.log @

        if "#{@module}/#{@method}" isnt 'empire/login'

            @sessionId ?= YAHOO.lacuna.Game.GetSession()

            if _.isObject params
                params['session_id'] = @sessionId
            else if _.isArray params
                params = [@sessionId].concat params

        # Define the data that'll get sent to the server.
        data =
            jsonrpc: '2.0'
            id: 1
            method: @method
            params: params

        # Also setup the url for all this to be sent to.
        sendUrl = resolve YAHOO.lacuna.Game.RPCBase, @url

        console.log sendUrl
        console.log data

        # Now that we've sorted all that `params` stuff out. Let's send the request!
        request
            .post sendUrl
            .send data
            .set 'Content-Type', 'application/json'
            .end (res) ->
                if res.ok
                    console.log 'ok'
                    console.log res.body
                else
                    console.log 'error'
                    console.log res
                    console.log res.body
                    console.log res.error.message



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
