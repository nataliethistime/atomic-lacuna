###
# Client
#
###

modules = require 'js/client/modules'


class Client

    ###
    # ## Client.send
    # Send stuff to the server.
    ###

    send: ->
        # TODO


# Initialize all of the methods that belong in the `Client` using the `modules` object.
methods = {}

func = (module, key) ->

    if module.methods
        _.each module.methods, (name) ->
            methods[key] ?= {}
            methods[key][name] = _.bind(Client::send, {url : module.url})


_.each modules, func
_.assign(Client::, methods)

console.log methods

module.exports = new Client()
