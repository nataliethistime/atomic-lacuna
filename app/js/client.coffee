###
# # Client
# This is the client Node-based client that should work better and be easier to
# work with than the included `YUI` client.
###

'use strict'

modules = require 'js/client/modules'
util = require 'js/util'

http = require 'https'
{parse, resolve} = require 'url'


###
# ## Session
# This is a static class used to store the session id. We cannot store the session
# id inside the `Client` class because of the way that the `send` methods are setup.
# See below...
###

class Session

    get: ->
        unless @sessionId
            @sessionId = YAHOO.lacuna.Game.GetSession()

        @sessionId


###
# ## Client
# This is the class in which all available API methods are defined. When you `require`
# this module it returns an instance of this class. See the documentation for
# **Client.send** for some example usages.
###

class Client


    ###
    # ## Client.prepareParams
    # Adds the session id to the `params` (wheather it be object or array).
    #
    # When `params` is `undefined` it defaults to an empty array. There aren't
    # any API methods that take an empty object or empty array. So either way, if this
    # happens, it'll probably throw an error.
    #
    # Note: **all** requests excluding `/empire/login()` require a session id.
    ###

    prepareParams: (params) ->

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


    ###
    # ## Client.preparePostData
    # Returns the object that the Lacuna server requires to be sent in. It's basically
    # a JSON RPC 2.0 request. There's more information about this object at
    # [Lacuna's HTTP Docs](http://us1.lacunaexpanse.com/api/#HTTP_POST).
    ###

    preparePostData: (params) ->
        jsonrpc: '2.0'
        id: 1
        method: @method
        params: params


    ###
    # ## Client.prepareRequestOptions
    # Creates the object which is passed into
    # [http.request()](http://nodejs.org/docs/latest/api/http.html#http_http_request_options_callback)
    #
    # The docs aren't clear about how the `url` is meant to be handled. So, we call
    # `url.parse` on it, which generates an object that Node can use to send the request.
    # For some reason we can't just supply a href or something.
    ###

    prepareRequestOptions: (url) ->
        options =
            method: 'POST'
            port: 80
            headers:
                'Content-Type': 'application/json'

        sendUrl = resolve YAHOO.lacuna.Game.RPCBase, url
        _.assign options, parse sendUrl

        options


    ###
    # ## Client.send
    # This is the main beast of this class. It takes in an object of parameters
    # and some callbacks and does all the magic HTTP stuff.
    #
    # Below are some examples for using this class to send server requests.
    #
    # **TODO: add some examples!!!!**
    ###

    send: (options) ->
        console.log @

        data = @preparePostData @prepareParams options.params
        requestOptions = @prepareRequestOptions @url

        console.log 'Sending ', data.params, 'to', requestOptions.href

        req = http.request requestOptions, _.partialRight @handleRpcRes, options
        req.on 'error', _.partialRight @handleRpcErr, options
        req.write JSON.stringify data
        req.end()


    ###
    # ## Client.handleRpcRes
    # This is the method that `Client.send` calls when a request succeeds.
    # It's given a `res` object which is an instance of Node's
    # [http.IncomingMessage class](http://nodejs.org/docs/latest/api/http.html#http_http_incomingmessage).
    # The `options` object is all of the options passed to the original `Client.send` call.
    #
    # This method handles Node's chunking of the response string. It also parses
    # the resulting string into JSON and tries to call the correct callback.
    #
    # When the Lacuna server returns a `result` block, the request has succeeded.
    # But when there's an `error` block, there's an error that needs to be looked after.
    ###

    handleRpcRes: (res, options) ->
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
                throw new Error 'Unrecognized options passed into Client.send()'


    ###
    # ## Client.handleRpcErr
    # This will be a HTTP error (404, for example) not an in-game error.
    # As such, I don't really have anything smart to do here.
    ###

    handleRpcErr: (err, options) ->
        console.log 'HTTP error...'
        console.log err, options


###
# # Client Initialization
# Initialize all of the methods that belong in the `Client` using the `modules`
# object. This is done here mostly because I'm lazy. So, it it matters so much,
# please *do* find a better place for this.
###


# Note: this `methods` object is used to store the methods during initialization
# so that when each function is bound to the `Client`'s `prototype`, it doesn't
# include all the other methods. This reduces the object down quite a lot.
methods = {}


###
# ## save
# Loops through each of the method names in `methodList` and binds a clone of the
# `Client`'s prototype, the `url` and the `method` to a new function. This new
# function is put into the above `methods` object and taken care of later.
###

save = (path, url, methodList) ->
    _.each methodList, (method) ->
        sendFunc = _.bind Client::send, _.assign _.clone(Client::), {url, method}
        util.deepSet(methods, "#{path}.#{method}", sendFunc)


###
# ## func
# This is the recursive function which tries to loop through the entire object.
# On each iteration, if the current object has a `url`, `methods` and `path`,
# then it's sent off to be put into the collection of callable server methods.
###

func = (value, key) ->

    if value.url? and value.methods? and value.path?
        save(value.path, value.url, value.methods)

    if _.isObject value
        _.each value, func


# Kick off the recursion and save the resulting object into the `Client`'s `prototype`.
_.each modules, func
_.assign(Client::, methods)

# Test the stuffs
# Note: this is test code and doesn't need to be documented. It will be removed later.
thing = new Client()
thing.Empire.get_status
    params: []
    scope: @
    success: (result) ->
        console.log 'success'
        console.log result
    error: (error) ->
        console.log error
        console.log 'error'


module.exports = new Client()
