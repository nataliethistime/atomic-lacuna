'use strict';
YAHOO.namespace("lacuna.modules");
(function() {
    var Lang = YAHOO.lang,
        Util = YAHOO.util,
        Dom = Util.Dom,
        Event = Util.Event,
        Sel = Util.Selector,
        Lacuna = YAHOO.lacuna,
        Game = Lacuna.Game,
        Lib = Lacuna.Library;
    var StationCommand = function(result) {
        StationCommand.superclass.constructor.call(this, result);
        this.service = Game.Services.Modules.StationCommand;
    };
    Lang.extend(StationCommand, Lacuna.buildings.PlanetaryCommand);
    Lacuna.modules.StationCommand = StationCommand;
})();