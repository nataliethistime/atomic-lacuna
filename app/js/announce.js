/*global YAHOO, $ */
'use strict';
YAHOO.namespace("lacuna");
var Templates = require('js/templates');
(function () {
    var Lang = YAHOO.lang,
        Lacuna = YAHOO.lacuna,
        Game = Lacuna.Game;
    var Announce = function () {
        this.id = "announce";
        var container = $('<div></div>')
            .attr('id', this.id)
            .addClass('nofooter');
        $(document.body)
            .prepend(container);
        this.Panel = new YAHOO.widget.Panel(this.id, {
            constraintoviewport: true,
            fixedcenter: false,
            visible: false,
            draggable: true,
            effect: Game.GetContainerEffect(),
            underlay: false,
            modal: false,
            close: true,
            width: "350px",
            zIndex: 19999,
            context: ["header", "tr", "br", ["beforeShow", "windowResize"],
                [0, 20]
            ]
        });
        this.Panel.setHeader('Announcements');
        this.Panel.render();
        // Note: we don't add this to the window manager because other windows
        // might close all windows (such as this one) through it.
    };
    Announce.prototype = {
        template: Templates.get('menu.announcement'),
        show: function () {
            this.render();
            this.Panel.show();
        },
        render: function () {
            var uri = "/announcement?session_id=" + Game.GetSession();
            this.Panel.setBody(this.template({
                uri: uri
            }));
        },
        hide: function () {
            this.Panel.hide();
        }
    };
    Lang.augmentProto(Announce, YAHOO.util.EventProvider);
    Lacuna.Announce = new Announce();
}());