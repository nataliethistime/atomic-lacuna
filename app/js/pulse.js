'use strict';
YAHOO.namespace("lacuna");
(function () {
    var Pulse = function () {
        var panel = new YAHOO.widget.Panel("pulsing", {
            fixedcenter: true,
            close: false,
            underlay: "none",
            draggable: false,
            //effect:{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.2},
            modal: false,
            visible: false,
            width: "100px"
        });
        YAHOO.util.Dom.removeClass("pulsing", "hidden");
        panel.render();
        this._panel = panel;
        this.counter = 0;
    };
    Pulse.prototype = {
        Show: function () {
            this._panel.bringToTop();
            this._panel.show();
            //this.counter++;
        },
        Hide: function () {
            //this.counter--;
            //if(this.counter <= 0) {
            //    this.counter = 0;
            this._panel.hide();
            //}
        }
    };
    YAHOO.lacuna.Pulse = Pulse;
})();