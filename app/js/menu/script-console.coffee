'use strict'

templates = require 'js/templates'
util = require 'js/util'

Lang = YAHOO.lang
Lacuna = YAHOO.lacuna
Game = Lacuna.Game

class ScriptConsole
    constructor: ->

        @id = 'about'
        @template = templates.get 'menu.scriptConsole'

        container = $('<div></div>').attr('id', @id).addClass('nofooter')
        $(document.body).prepend container

        @panel = new YAHOO.widget.Panel @id,
            constraintoviewport: true
            fixedcenter: true
            visible: false
            draggable: true
            effect: Game.GetContainerEffect()
            underlay: false
            close: true
            width: '600px'
            zIndex: 9999

        @panel.setHeader 'Script Console'
        @panel.render()
        Game.OverlayManager.register @panel

    show: ->
        @render()
        @open()

    open: ->
        Game.OverlayManager.hideAll()
        @panel.show()
        @panel.center()

    hide: ->
        @panel.hide()

    render: ->
        @panel.setBody @template()


module.exports = new ScriptConsole()
