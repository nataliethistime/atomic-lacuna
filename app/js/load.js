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

    var host = window.lacuna_code_base_url || window.lacuna_s3_base_url;
    var loader = new YAHOO.util.YUILoader({
        base: "http://ajax.googleapis.com/ajax/libs/yui/2.9.0/build/",
        filter: "RAW",
        allowRollup: false,
        combine: false
    });

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

        YAHOO.widget.Logger.enableBrowserConsole();
        YAHOO.lacuna.Game.Start(query);
        progressLoaderC.parentNode.removeChild(progressLoaderC);
    };
    loader.onProgress = function(o) {
        if(firstFile) {
            if(this._combining) {
                //remove the count of the files that are getting combined but still record it as 1 file
                progressLoader.total = this.sorted.length - this._combining.length + 1;
            }
            else {
                progressLoader.total = this.sorted.length;
            }
            firstFile = undefined;
        }
        progressLoader.counter++;
        var perc = progressLoader.counter / progressLoader.total;
        progressLoader.style.width = Math.ceil(perc * progressLoaderC.offsetWidth) + "px";
        progressLoader.innerHTML = [
            Math.round(perc * 1000) / 10,
            '% - ',
            progressLoader.counter < status.length ? status[progressLoader.counter] : o.name
        ].join('');
    };
    loader.onFailure = function(o) {
        YAHOO.log(o);
    };

    //pre calc so we can discover how many files are getting loaded for the progress bar
    loader.calculate();

    var status = [
            'loading ships',
            'starting engines',
            'breaking atmo',
            'calculating trajectory',
            'engaging hyper drive',
            'travelling the verse',
            'other witty comments',
            'reticulating splines',
            'compacting nebulas',
            'colliding asteroids',
            'corroding spreadsheets',
            'irradiating pneumatic systems',
            'constructing universe',
            'detonating luggage',
            'harvesting politicians',
            'inflating government structure',
            'discrediting liquids',
            'camoflaging nerds',
            'vilifying heroes',
            'flooding prairies',
            'nebulizing nebulas',
            'spinning plates',
            'fortifying bread',
            'lambasting vampires',
            'elevating vectors',
            'caching favors',
            'predicting history',
            'looking suave',
            'babelizing translations',
            'necrotizing decimals',
            'capitalizing numerals',
            'compressing water',
            'reliving the past',
            'delivering ingots',
            'bottling particles',
            'refactoring physics',
            'cavitating airflow',
            'corrupting time stream',
            'unbalancing gyroscopes',
            'fishing for compliments',
            'refuting evidence',
            'rotating pinions',
            'engaging clutch',
            'ejecting pilot',
            'reciting poetry',
            'investigating rumors',
            'deconstructing philosophies',
            'monetizing colors',
            'digitizing electrolytes',
            'motivating livestock',
            'assuming the worst',
            'ignoring mummies',
            'disconnecting engineers',
            'remembering the future',
            'broadcasting the truth',
            'entertaining the possibility',
            'developing a theory',
            'making friends',
            'oxidizing lizards',
            'coercing automatons',
            'dissociating ions',
            'taking a break',
            'watching paint dry',
            'decanting the clones',
            'motoring movers',
            'scaping goats',
            'assembling deployments',
            'deploying assemblages',
            'taking candy from a baby',
            'turning water into wine',
            'making it go',
            'spelunking for camels',
            'perambulating procedures',
            'kicking the tires',
            'setting launch codes',
            'defining reality',
            'making a list',
            'checking it twice',
            'delving into the unthinkable',
            'doing the impossible',
            'pushing the button'
        ],
        firstFile = true,
        progressLoaderC = document.createElement("div"),
        progressLoader = progressLoaderC.appendChild(progressLoaderC.cloneNode(false));
    var s = status.length;
    while ( --s ) {
        var j = Math.floor( Math.random() * ( s + 1 ) );
        var tempi = status[s];
        var tempj = status[j];
        status[s] = tempj;
        status[j] = tempi;
    }

    //container
    progressLoaderC.id = "loadingProgress";
    progressLoaderC.style.backgroundColor = '#FFD800';
    progressLoaderC.style.position = 'absolute';
    progressLoaderC.style.top = '30px';
    progressLoaderC.style.left = '30px';
    progressLoaderC.style.right = '30px';
    //progress bar
    progressLoader.counter = 0;
    progressLoader.style.backgroundColor = "#fff";
    progressLoader.style.textAlign = "left";
    progressLoader.style.paddingLeft = "10px";
    progressLoader.style.color = "black";
    progressLoader.style.height = "30px";
    progressLoader.style.lineHeight = "30px";
    progressLoader.style.width = "1px";
    progressLoader.style.overflow = "visible";
    progressLoader.style.whiteSpace = "nowrap";
    progressLoader.innerHTML = status[progressLoader.counter];

    document.body.insertBefore(progressLoaderC, document.body.firstChild);
    loader.insert();
})();
// vim: noet:ts=4:sw=4
