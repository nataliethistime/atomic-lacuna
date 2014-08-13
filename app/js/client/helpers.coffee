###
# # Helpers
# This is a collection of methods that can be called in the same style as the
# server API methods found in the client. They are merged in with the generated
# server methods.
#
# For good examples of using these please see the `Push Glyphs` task.
###

'use strict'

modules = require 'js/client/modules'
client = require 'js/client'
util = require 'js/util'

helpers =
    body:


        ###
        # ## body.findBuilding
        # Takes a `buildings` object (as returned from `body.get_buildings`) and
        # finds the building as specified by `name`. Aldo, allow mixing in of a building's
        # rpc methods and helper methods into the return value. So the following is possible:
        #
        # ```
        # trade = body.findBuilding buildings, name
        # trade.getGlyphInventory [trade.id]
        # ```
        ###

        findBuilding: (buildings, name) ->
            key = _.findKey buildings, {name}

            return null unless key?

            obj = _.clone buildings[key]
            obj.id = key

            # Do a fresh require to avoid issues with circular dependencies.
            client = require 'js/client'

            {path} = modules.Buildings[_.findKey(modules.Buildings, url: obj.url)]
            methods = util.deepGet client, path
            _.assign obj, methods

            obj


    buildings:
        trade:


            ###
            # ## buildings.trade.getGlyphInventory
            # Get an object of the glyphs where the key is the name of the glyph
            # and the value is the quantity.
            #
            # Note that to carry on the chain after this promise statement, you
            # need to use a `spread` instead of `then`. This is because multiple
            # values are returned from this function.
            ###

            getGlyphInventory: () ->
                @get_glyph_summary [@id]
                .then (res) ->
                    glyphs = {}
                    glyphs[glyph.name] = glyph.quantity for glyph in res.glyphs

                    [glyphs, res.cargo_space_used_each]


module.exports = helpers
