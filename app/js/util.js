var path = require('path');
// Need to load this here because Util.root() is called before Lodash is global-ised.
var _ = require('lodash');
module.exports = {
    _cwd: process.cwd(),
    root: function () {
        // Get a full path to the app/ directory
        cwd = this._cwd || process.cwd();
        // When in development mode, the cwd is:
        // /home/vasari/atomic-lacuna
        // In a build, it's:
        // /home/vasari/atomic-lacuna/build/linux_binary
        if (_.last(cwd.split(path.sep)) == 'atomic-lacuna') {
            return path.join(process.cwd(), 'app');
        }
        return path.join(process.cwd(), 'resources', 'app');
    }
}