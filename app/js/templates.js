var Handlebars = require('handlebars'),
    fs = require('fs'),
    path = require('path');


// Define all the Handlebars helpers.
require('js/templateHelpers');

module.exports = {
    tmplCache : {

    },

    get : function (name) {
        // Get from cache or load new one.
        return this.tmplCache[this.addPrefix(name)] || this.load(name);
    },

    load : function (name) {
        var buffer, location;

        // Add the file extension and fix /'s
        name = this.fixName(name);

        if (window.ATOM_SHELL) {
            // We can use the file system to get the templates.
            buffer = fs.readFileSync(this.getLocation(name));
            return this.save(name, this.prepare(buffer.toString()));
        }
        else {
            // If it can't be gotten from the file system, then it isn't here.
            throw new Error('Template had not been loaded: ' + name);
        }
    },

    save : function (name, func) {
        this.tmplCache[this.addPrefix(name)] = func;
        return func;
    },

    prepare : function (string) {
        string = string.replace(/\n/g, ''); // Remove newlines.
        string = string.replace(/\s{2,}/g, ''); // Weed out whitespace.
        return Handlebars.compile(string);
    },

    fixName : function (name) {
        name = name.replace(/\./g, path.sep);
        return name + '.html';
    },

    addPrefix : function (name) {
        return '__' + name;
    },

    getLocation : function (name) {
        var cwd = process.cwd();

        // When in development mode, the cwd is:
        // /home/vasari/atomic-lacuna
        // In a build, it's:
        // /home/vasari/atomic-lacuna/build/linux_binary
        // but when in
        if (_.last(cwd.split(path.sep)) == 'atomic-lacuna') {
            return path.join(process.cwd(), 'app', 'templates', name);
        }

        return path.join(process.cwd(), 'resources', 'app', 'templates', name);
    }
}
