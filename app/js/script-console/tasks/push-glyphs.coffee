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

        empire.get_status []
        .bind @
        .then (res) ->
            @planets = _.invert res.empire.planets
            @fromId = @planets[@fromName]
            @toId = @planets[@toName]

            body.get_buildings [@fromId]

        .then (res) ->
            @

        .done callback



module.exports = new PushGlyphs()
