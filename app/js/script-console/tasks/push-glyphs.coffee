###
# # Push Glyphs
# A task to use any available transport ship to push all glyphs on one planet
# to a different planet.
###

'use strict'

templates = require 'js/templates'
Task = require 'js/task'

{empire, body} = require 'js/client'

class PushGlyphs extends Task

    displayName: 'Push Glyphs'
    internalName: 'pushGlyphs'

    template: templates.get 'tasks.pushGlyphs'


    ###
    # ## PushGlyphs.loadOptions
    # See the documentation for the `Task` class for what this is.
    ###
    loadOptions: ->
        @fromName = $('#pushGlyphsFrom').val()
        @toName = $('#pushGlyphsTo').val()


    ###
    # ## PushGlyphs.run
    # See the documentation for the `Task` class for what this is.
    ###
    run: (callback) ->

        # Create local references to these variables because they're not accessible
        # inside the promise callbacks.
        {fromName, toName} = @

        fromId = 0
        toId = 0

        empire.get_status
            params: []
        .then (res) ->
            planets = _.invert res.empire.planets
            fromId = planets[fromName]
            toId = planets[toName]

            body.get_buildings
                params: [fromId]
        .then (res) ->
            console.log res

        .done callback



module.exports = new PushGlyphs()
