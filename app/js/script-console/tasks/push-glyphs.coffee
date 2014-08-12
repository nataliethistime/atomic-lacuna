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

            {buildings} = res
            @trade = body.findBuilding buildings, 'Trade Ministry'
            @trade.getGlyphInventory()

        .spread (@glyphs, @glyphCargoSpace) ->
            @trade.get_trade_ships [@trade.id, @toId]

        .then (res) ->

            @ships = _.sortBy res.ships, (ship) ->
                _.parseInt ship.hold_size
            .reverse()

            @ship = _.first @ships

            toPush = []
            total = 0
            max = _.parseInt @ship.hold_size

            for name, quantity of @glyphs
                quantity = _.parseInt quantity
                thing = (total + quantity) * @glyphCargoSpace

                if thing > max
                    continue
                else
                    toPush.push {type: 'glyph', name, quantity}
                    total += quantity


            @trade.push_items [@trade.id, @toId, toPush, ship_id: @ship.id]

        .then (res) ->
            console.log 'Success!' if res.ship.task is 'Travelling'

        .done callback



module.exports = new PushGlyphs()
