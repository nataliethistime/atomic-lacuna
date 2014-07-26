'use strict'

templates = require 'js/templates'
util = require 'js/util'

Lang = YAHOO.lang
Lacuna = YAHOO.lacuna
Game = Lacuna.Game

class About extends YAHOO.util.EventProvider
    constructor: ->

        @id = 'about'
        @createEvent 'onShow'
        @template = templates.get 'menu.about'

        container = $('<div></div>').attr('id', @id).addClass('nofooter')
        $(document.body).prepend container

        @panel = new YAHOO.widget.Panel @id,
            constraintoviewport: true
            fixedcenter: true
            visible: false
            draggable: true
            effect: Game.GetContainerEffect()
            underlay: false
            modal: true
            close: true
            width: '450px'
            zIndex: 9999

        @panel.setHeader 'About'
        @panel.render()
        Game.OverlayManager.register @panel

    show: ->
        unless @hasCredits
            Game.Services.Stats.credits {},
                success: (o) ->
                    YAHOO.log o, 'info', 'Stats'
                    @render o
                    @hasCredits = true
                    @open()
                scope: @
        else
            @open()

    open: ->
        Game.OverlayManager.hideAll()
        @panel.show()
        @panel.center()

    hide: ->
        @panel.hide()

    render: (o) ->
        @panel.setBody @template(o)
        $('#aboutVersion').html Game.ServerData.version
        $('#aboutYear').html util.year()


module.exports.About = new About()
