'use strict';
var path = require('path');
module.exports = {
    _cwd: process.cwd(),
    root: function() {
        // Get a full path to the app/ directory
        var cwd = this._cwd || process.cwd();
        // When in development mode, the cwd is:
        // /home/vasari/atomic-lacuna
        // In a build, it's:
        // /home/vasari/atomic-lacuna/build/linux_binary
        if (_.last(cwd.split(path.sep)) === 'atomic-lacuna') {
            return path.join(process.cwd(), 'app');
        }
        return path.join(process.cwd(), 'resources', 'app');
    },

    // Taken straight from http://stackoverflow.com/a/13719799/1978973
    // and modified in places.
    deepSet: function(obj, name, value) {
        if (_.isString(name)) {
            name = name.split('.');
        }

        if (name.length > 1) {
            var e = name.shift();
            this.deepSet(obj[e] = _.isObject(obj[e]) ? obj[e] : {}, name, value);
        }
        else {
            obj[name[0]] = value;
        }
    },

    deepGet: function(obj, name) {
        // name is a '.' separated string indicating where in obj it belongs.
        var pieces = name.split('.');
        var last = undefined;

        _.each(pieces, function(piece) {
            last = (last || obj)[piece] || {};
        });

        return _.isUndefined(last) ? undefined : last;
    }
};
