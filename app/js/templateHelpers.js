var Handlebars = require('handlebars');

var Lacuna = YAHOO.lacuna,
    Lib = Lacuna.Library;

// Used in the Production tab of all buildings. Returns 'low-resource' if
// if current - upgrade > planet.
Handlebars.registerHelper('lowResource', function (current, upgrade, planet) {
    if (current - upgrade > planet) {
        return 'low-resource';
    }
    return '';
});

Handlebars.registerHelper('lowCost', function (cost, current) {
    if (cost > current) {
        return 'low-resource';
    }
    return '';
});

// Used in a building's Production tab to remove the error code from a downgrade
// error message.
Handlebars.registerHelper('removeLeadingErrorCode', function (string) {
    return string.toString().replace(/^\d+,\s*/, '');
});

Handlebars.registerHelper('formatTime', function (string) {
    return Lib.formatTime(string);
});