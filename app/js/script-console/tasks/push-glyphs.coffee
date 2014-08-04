###
# # Push Glyphs
# A task to use any available transport ship to push all glyphs on one planet
# to a different planet.
###

'use strict'

templates = require 'js/templates'
Task = require 'js/task'

{Empire} = require 'js/client'

class PushGlyphs extends Task

    displayName: 'Push Glyphs'
    internalName: 'pushGlyphs'

    template: templates.get 'tasks.pushGlyphs'


    ###
    # ## PushGlyphs.loadOptions
    # See the documentation for the `Task` class for what this is.
    ###
    loadOptions: ->
        # TODO


    ###
    # ## PushGlyphs.run
    # See the documentation for the `Task` class for what this is.
    ###
    run: (callback) ->

        Empire.get_status
            params: []
        .then (res) ->
            console.log res
        , (err) ->
            console.log err
        .done(callback);



module.exports = new PushGlyphs()
