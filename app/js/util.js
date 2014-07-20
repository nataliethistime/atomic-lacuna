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
    }
};