(function() {
    // This converts url parameters into a usable object. I think it's only used
    // in the registration process when someone clicks a referral link (which
    // has a code in the url as a parameter.)
    var l = window.location;
    var query = {};
    var vars = l.hash.substring(1).split('&');
    if (vars.length > 0) {
        for (var i=0; i<vars.length; i++) {
            var pair = vars[i].split("=");
            query[pair[0]] = decodeURIComponent(pair[1]);
        }
    }
    if (window.history.replaceState) {
        window.history.replaceState({}, document.title, l.protocol+'//'+l.host+l.pathname+l.search);
    }
    else if (l.hash != '') {
        l.hash = '';
    }


    // Make sure the pulser is hidden.
    var p = document.getElementById("pulsing");
    if(p.className.indexOf('hidden') < 0) {
        p.className += ' hidden';
    }

    var loader = new YAHOO.util.YUILoader({
        base: require('path').join(process.cwd(), 'lib', 'yui2', 'build') + '/',
        filter: "RAW",
        allowRollup: false,
        combine: false
    });

    // List of YUI2 components that need to be loaded.
    loader.require([
        "autocomplete",
        "logger",
        "yahoo",
        "dom",
        "connection",
        "get",
        "json",
        "event",
        "container",
        "dragdrop",
        "slider",
        "animation",
        "selector",
        "event-delegate",
        "event-mouseenter",
        "paginator",
        "tabview",
        "menu"
    ]);

    loader.onSuccess = function(o) {
        // Require the new boyz on the street!
        window.$ = require('jquery');
        window._ = require('lodash');

        // RPC and core stuff
        require('js/smd');
        require('js/rpc');
        require('js/library');
        require('js/game');

        // Misc?
        require('js/about');
        require('js/announce');

        // Empire management and star map
        require('js/speciesDesigner');
        require('js/createSpecies');
        require('js/createEmpire');
        require('js/login');
        require('js/mapper');
        require('js/mapStar');

        // Buildings
        require('js/building');
        require('js/buildingArchaeology');
        require('js/buildingBlackHoleGenerator');
        require('js/buildingCapitol');
        require('js/buildingDevelopment');
        require('js/buildingDistributionCenter');
        require('js/buildingEmbassy');
        require('js/buildingEnergyReserve');
        require('js/buildingEntertainment');
        require('js/buildingFoodReserve');
        require('js/buildingGeneticsLab');
        require('js/buildingIntelligence');
        require('js/buildingIntelTraining');
        require('js/buildingLibraryOfJith');
        require('js/buildingMayhemTraining');
        require('js/buildingMercenariesGuild');
        require('js/buildingMiningMinistry');
        require('js/buildingMissionCommand');
        require('js/buildingNetwork19');
        require('js/buildingObservatory');
        require('js/buildingOracleOfAnid');
        require('js/buildingOreStorage');
        require('js/buildingPark');
        require('js/buildingPlanetaryCommand');
        require('js/buildingPoliticsTraining');
        require('js/buildingSecurity');
        require('js/buildingShipyard');
        require('js/buildingSpacePort');
        require('js/buildingSpaceStationLab');
        require('js/buildingSubspaceSupplyDepot');
        require('js/buildingTempleOfTheDrajilites');
        require('js/buildingTheftTraining');
        require('js/buildingThemePark');
        require('js/buildingTheDillonForge');
        require('js/buildingTradeMinistry');
        require('js/buildingTransporter');
        require('js/buildingWasteExchanger');
        require('js/buildingWasteRecycling');
        require('js/buildingWaterStorage');
        require('js/moduleParliament');
        require('js/modulePoliceStation');
        require('js/moduleStationCommand');

        // Planet map
        require('js/mapPlanet');

        // Menu stuff
        require('js/textboxList');
        require('js/messaging');
        require('js/essentia');
        require('js/invite');
        require('js/profile');
        require('js/stats');
        require('js/pulse');
        require('js/info');
        require('js/notify');
        require('js/captcha');
        require('js/menu');


        // Start everything!
        YAHOO.widget.Logger.enableBrowserConsole();
        YAHOO.lacuna.Game.Start(query);
    };

    // Start the loading process.
    loader.insert();
})();
