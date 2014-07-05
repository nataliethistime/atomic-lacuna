/*global YAHOO, $ */
'use strict';

YAHOO.namespace("lacuna");

var Templates = require('js/templates');

(function () {
    var Lang = YAHOO.lang,
        Lacuna = YAHOO.lacuna,
        Game = Lacuna.Game;

    var About = function () {
        this.id = "about";
        this.createEvent("onShow");

        var container = $('<div></div>').attr('id', this.id).addClass('nofooter');
        $(document.body).prepend(container);

        this.panel = new YAHOO.widget.Panel(this.id, {
            constraintoviewport : true,
            fixedcenter : true,
            visible : false,
            draggable : true,
            effect : Game.GetContainerEffect(),
            underlay : false,
            modal : true,
            close : true,
            width : '450px',
            zIndex : 9999
        });

        this.panel.setHeader('About');

        this.panel.render();
        Game.OverlayManager.register(this.panel);
    };

    About.prototype = {
        template : Templates.get('menu.about'),

        show : function () {
            if (!this.hasCredits) {
                Game.Services.Stats.credits({}, {
                    success : function (o) {
                        YAHOO.log(o, "info", "Stats");
                        this.render(o);
                        this.hasCredits = true;
                        this.open();
                    },
                    scope : this
                });
            } else {
                this.open();
            }
        },

        open : function () {
            Game.OverlayManager.hideAll();
            this.panel.show();
            this.panel.center();
        },

        hide : function () {
            this.panel.hide();
        },

        render : function (o) {
            this.panel.setBody(this.template(o));
            $('#aboutVersion').html(Game.ServerData.version);
            $('#aboutYear').html((new Date()).getFullYear());
        }
    };

    Lang.augmentProto(About, YAHOO.util.EventProvider);
    Lacuna.About = new About();
}());
