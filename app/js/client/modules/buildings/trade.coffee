'use strict'
module.exports =
    url: '/trade'
    path: 'buildings.trade'
    methods: [
        'add_to_market'
        'get_ship_summary'
        'get_ships'
        'get_prisoners'
        'get_plan_summary'
        'get_plans'
        'get_glyph_summary'
        'get_glyphs'
        'withdraw_from_market'
        'accept_from_market'
        'view_market'
        'view_my_market'
        'get_trade_ships'
        'get_waste_ships'
        'get_supply_ships'
        'view_supply_chains'
        'view_waste_chains'
        'create_supply_chain'
        'delete_supply_chain'
        'update_supply_chain'
        'update_waste_chain'
        'add_supply_ship_to_fleet'
        'add_waste_ship_to_fleet'
        'remove_supply_ship_from_fleet'
        'remove_waste_ship_from_fleet'
        'get_stored_resources'
        'push_items'
        'report_abuse'
    ]

    helpers:

        ###
        # ## buildings.trade.getGlyphInventory
        # Get an object of the glyphs where the key is the name of the glyph
        # and the value is the quantity.
        #
        # Note that to carry on the chain after this promise statement, you
        # need to use a `spread` instead of `then`. This is because multiple
        # values are returned from this function.
        ###

        getGlyphInventory: ->
            @get_glyph_summary [@id]
            .then (res) ->
                glyphs = {}
                glyphs[glyph.name] = glyph.quantity for glyph in res.glyphs

                [glyphs, res.cargo_space_used_each]
