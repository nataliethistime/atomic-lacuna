/*global YAHOO */

// This is a data structure of all the assets used by the game. This should make
// adding/changing assets in the templates easier.

// The starting url all the assets are based off.
var s = YAHOO.lacuna.Library.AssetUrl,
    join = require('path').join;

module.exports = {
    ui : {
        small : {
            food : join(s, 'ui', 's', 'food.png'),
            ore : join(s, 'ui', 's', 'ore.png'),
            water : join(s, 'ui', 's', 'water.png'),
            energy : join(s, 'ui', 's', 'energy.png'),
            waste : join(s, 'ui', 's', 'waste.png'),
            happiness : join(s, 'ui', 's', 'happiness.png'),
            time : join(s, 'ui', 's', 'time.png'),
            refresh : join(s, 'ui', 's', 'refresh.png')
        },

        large : {

        }
    }
};
