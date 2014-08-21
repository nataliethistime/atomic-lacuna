###
# # Client
# This is the client Node-based client that should work better and be easier to
# work with than the old `YUI` client.
###

'use strict'

# Get the right edition of the `request` module.
request = if window.ATOM_SHELL then require 'request' else require 'browser-request'

url = require 'url'
Promise = require 'bluebird'

Session = require 'js/client/session'
util = require 'js/util'

class Client

    # Use this variable to check if this is an initialized version of the client object.
    initialized: no


    constructor: ->
        # This `methods` object is used to store the methods during initialization
        # so that when each function is bound to the `Client`'s `prototype`, it doesn't
        # include all the other methods. This reduces the object down quite a lot.
        methods = {}


        ###
        # ## save
        # Loops through each of the method names in `methodList` and binds a clone of the
        # `Client`'s prototype, the `url` and the `method` to a new function. This new
        # function is put into the above `methods` object and taken care of later.
        ###

        save = (path, url, methodList) =>
            _.each methodList, (method) =>
                sendFunc = _.bind Client::send, _.assign _.clone(Client::), {url, method}
                util.deepSet(methods, "#{path}.#{method}", sendFunc)


        ###
        # ## saveHelpers
        # Saves the helpers into the object thing-o. Whatever.
        ###

        saveHelpers = (helpers, path) ->
            _.each helpers, (helper, name) ->
                util.deepSet methods, "#{path}.#{name}", helper


        ###
        # ## func
        # This is the recursive function which tries to loop through the entire object.
        # On each iteration, if the current object has a `url`, `methods` and `path`,
        # then it's sent off to be put into the collection of callable server methods.
        ###

        func = (value, key) ->

            if value.url? and value.methods? and value.path?
                save(value.path, value.url, value.methods)

            if value.helpers? and value.path?
                saveHelpers(value.helpers, value.path)


        # Let's get this party started.
        _.each require('js/client/modules'), func
        _.merge @, methods

        @initialized = yes


    ###
    # ## Client.prepareParams
    # Adds the session id to the `params` (whether it be object or array).
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
    # Creates the object which is passed into the `request` method.
    ###

    prepareRequestOptions: (data) ->
        json: data
        timeout: 20 * 1000


    ###
    # ## Client.send
    # This is the main beast of this class. It takes in an object of parameters
    # and some callbacks and does all the magic HTTP stuff.
    #
    # Below are some examples for using this class to send server requests.
    #
    # **TODO: add some examples!!!!**
    ###

    send: (params) ->

        data = @preparePostData @prepareParams params
        sendUrl = url.resolve YAHOO.lacuna.Game.RPCBase, @url

        console.log "#{sendUrl}.#{data.method}(", data.params, ')'

        @createSendPromise sendUrl, @prepareRequestOptions data


    ###
    # ## Client.createSendPromise
    # Uses [Bluebird](https://github.com/petkaantonov/bluebird) to make this
    # request into a promise.
    #
    # When a request comes in, if the body has a `result` than the request is
    # considered successful and is `resolve()`'d. Otherwise the data is `reject()`'d.
    ###

    createSendPromise: (sendUrl, requestOptions) ->

        new Promise (resolve, reject) ->

            request.post sendUrl, requestOptions, (error, response, body) ->
                if !error and response.statusCode is 200
                    if body.result
                        val = body.result or body
                        console.log '=>', val
                        resolve val
                    else if body.error
                        val = body.error
                        console.log '=>', val
                        resolve val
                else
                    throw error


module.exports = Client
