'use strict'

Lacuna = YAHOO.lacuna
Game = Lacuna.Game

###
# # Panel
# The class that other code interacts with for creating panels.
###
class Panel


    ###
    # ## Panel::DEFAULTS
    # These are the default options passed into YUI's panel constructor.
    ###

    DEFAULTS:
        constraintoviewport: true
        fixedcenter: true
        visible: false
        draggable: true
        close: true
        width: '600px'
        zIndex: 9999


    ###
    # ## Panel.constructor
    # The function that puts all of this stuff together.
    ###

    constructor: (options) ->

        @id = options.id or Math.random() * Math.random() * 200
        @template = options.template or (-> '')
        @args = options.args or {}

        container = $ '<div></div>'
            .attr 'id', @id
            .addClass 'nofooter'

        $ document.body
            .prepend container

        args = effect: Game.GetContainerEffect()
        _.assign args, Panel::DEFAULTS, @args

        @panel = new YAHOO.widget.Panel @id, args
        @panel.setHeader options.header or ''
        @panel.render()
        Game.OverlayManager.register @panel


    ###
    # ## Panel.show
    # This function shows the panel on the screen. It also renders the template
    # passed into the constructor.
    ###

    show: (templateVars = {}) ->
        @panel.setBody @template(templateVars) or ''
        @panel.show()


module.exports = Panel
