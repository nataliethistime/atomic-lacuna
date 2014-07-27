###
# # Push Glyphs
# A task to use any available transport ship to push all glyphs on one planet
# to a different planet.
###

'use strict'

Task = require 'js/task'

class PushGlyphs extends Task

    displayName: 'Push Glyphs'


module.exports = new PushGlyphs()
