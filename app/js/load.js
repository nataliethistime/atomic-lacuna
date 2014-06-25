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
        require('js/building/archaeology');
        require('js/building/blackHoleGenerator');
        require('js/building/capitol');
        require('js/building/development');
        require('js/building/distributionCenter');
        require('js/building/embassy');
        require('js/building/energyReserve');
        require('js/building/entertainment');
        require('js/building/foodReserve');
        require('js/building/geneticsLab');
        require('js/building/intelligence');
        require('js/building/intelTraining');
        require('js/building/libraryOfJith');
        require('js/building/mayhemTraining');
        require('js/building/mercenariesGuild');
        require('js/building/miningMinistry');
        require('js/building/missionCommand');
        require('js/building/network19');
        require('js/building/observatory');
        require('js/building/oracleOfAnid');
        require('js/building/oreStorage');
        require('js/building/park');
        require('js/building/planetaryCommand');
        require('js/building/politicsTraining');
        require('js/building/security');
        require('js/building/shipyard');
        require('js/building/spacePort');
        require('js/building/spaceStationLab');
        require('js/building/subspaceSupplyDepot');
        require('js/building/templeOfTheDrajilites');
        require('js/building/theftTraining');
        require('js/building/themePark');
        require('js/building/theDillonForge');
        require('js/building/tradeMinistry');
        require('js/building/transporter');
        require('js/building/wasteExchanger');
        require('js/building/wasteRecycling');
        require('js/building/waterStorage');
        require('js/module/parliament');
        require('js/module/policeStation');
        require('js/module/stationCommand');

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
