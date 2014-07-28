
###
# # Index
# This is the main file where all available Tasks the user can run are loaded from.
###

'use strict'

pushGlyphs = require 'js/script-console/tasks/push-glyphs'

module.exports[pushGlyphs.internalName] = pushGlyphs
