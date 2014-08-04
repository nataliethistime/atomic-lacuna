###
# # Client
# This is the client Node-based client that should work better and be easier to
# work with than the included `YUI` client.
###

'use strict'

modules = require 'js/client/modules'
util = require 'js/util'

# Get the right edition of the `request` module.
request = if window.ATOM_SHELL then require 'request' else require 'browser-request'

url = require 'url'
Q = require 'q'


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
    # Creates the object which is passed into the `request.request` method.
    #
    # The docs aren't clear about how the `url` is meant to be handled. So, we call
    # `url.parse` on it, which generates an object that Node can use to send the request.
    # For some reason we can't just supply a href or something.
    ###

    prepareRequestOptions: (data) ->
        json: data
        timeout: 5 * 1000


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

        data = @preparePostData @prepareParams options.params
        url = url.resolve YAHOO.lacuna.Game.RPCBase, @url

        # console.log url + '.' + data.method + '(', data.params, ')'
        console.log "#{url}.#{data.method}(", data.params, ')'

        @createSendPromise options, url, @prepareRequestOptions data


    ###
    # ## Client.createSendPromise
    # Uses `Q` to make this request into a promise. Great for chaining.
    ###

    createSendPromise: (options, url, requestOptions) ->

        Q.Promise (resolve, reject, notify) ->
            timeout = 5000

            request.post url, requestOptions, (error, response, body) ->
                unless error
                    if body.result
                        val = body.result or body
                        console.log '=>', val
                        resolve val
                    else if body.errorval = body.error
                        console.log '=>', val
                        resolve val
                else
                    # TODO: do something interesting here!
                    console.log "fatal error that shouldn't happen. Oh noes!"
                    console.log error


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
module.exports = new Client()
