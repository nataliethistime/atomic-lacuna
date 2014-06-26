var Handlebars = require('handlebars'),
    fs = require('fs'),
    path = require('path');

module.exports = {
    tmplCache : {

    },

    get : function (name) {
        // Get from cache or load new one.
        var cachedName = this.addPrefix(name);
        return this.tmplCache[cachedName] || this.load(name);
    },

    load : function (name) {
        var cachedName = this.addPrefix(name),
            buffer, func, string;

        // Add the file extension.
        name += '.html';

        if (window.ATOM_SHELL) {
            // We can use the file system to get the templates.
            buffer = fs.readFileSync(path.join(process.cwd(), 'app', 'templates', name));
            string = buffer.toString();
            string = string.replace(/\n/g, ''); // Remove newlines.
            string = string.replace(/\s{2,}/g, ''); // Weed out whitespace.
            func = Handlebars.compile(string);
            this.tmplCache[cachedName] = func;
            return func;
        }
        else {
            // TODO
        }
    },

    addPrefix : function (name) {
        return '__' + name;
    }
}
