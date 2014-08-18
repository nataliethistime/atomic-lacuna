'use strict'


###
# # Session
# This is a static class used to store the session id. We cannot store the session
# id inside the `Client` class because of the way that the `send` methods are setup.
# See below...
###

module.exports = class

    get: ->
        unless @sessionId
            @sessionId = YAHOO.lacuna.Game.GetSession()

        @sessionId
