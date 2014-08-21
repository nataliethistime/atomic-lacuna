'use strict'

Client = require 'js/client'
modules = require 'js/client/modules'

util = require 'js/util'

module.exports =
    url: '/body'
    path: 'body'
    methods: [
        'abandon'
        'get_buildings'
        'get_buildable'
        'get_build_queue'
        'get_status'
        'rename'
    ]

    helpers:
        ###
        # ## body.findBuilding
        # Takes a `buildings` object (as returned from `body.get_buildings`) and
        # finds the building as specified by `name`. Also, allow mixing in of a building's
        # rpc methods and helper methods into the return value. So the following is possible:
        #
        # ```
        # trade = body.findBuilding buildings, 'Trade Ministry'
        # trade.getGlyphInventory [trade.id]
        # ```
        ###

        findBuilding: (buildings, name) ->
            key = _.findKey buildings, {name}

            return null unless key?

            obj = _.clone buildings[key]
            obj.id = key

            client = new Client()

            {path} = modules[_.findKey(modules, url: obj.url)]
            methods = util.deepGet client, path
            _.assign obj, methods

            obj
