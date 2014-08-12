###
# # Helpers
#
###

'use strict'

module.exports =

    body:

        ###
        # # body.findBuilding
        # Takes a `buildings` object (as returned from `body.get_buildings`) and
        # finds the building as specified by `name`
        ###
        findBuilding: (buildings, name) ->
            key = _.findKey buildings, {name}
            obj = _.clone buildings[key]
            obj.id = key
            obj
