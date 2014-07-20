'use strict';
YAHOO.namespace("lacuna.modules");
(function() {
    var Lang = YAHOO.lang,
        Util = YAHOO.util,
        Dom = Util.Dom,
        Event = Util.Event,
        Pager = YAHOO.widget.Paginator,
        Sel = Util.Selector,
        Lacuna = YAHOO.lacuna,
        Game = Lacuna.Game,
        Lib = Lacuna.Library;
    var PoliceStation = function(result) {
        PoliceStation.superclass.constructor.call(this, result);
        this.service = Game.Services.Modules.PoliceStation;
        this.foreignSpiesMessage = "There may be spies on your station that we don't know about.";
    };
    Lang.extend(PoliceStation, Lacuna.buildings.Security);
    YAHOO.lacuna.modules.PoliceStation = PoliceStation;
})();