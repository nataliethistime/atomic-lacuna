'use strict';
var Handlebars = require('handlebars'),
    fs = require('fs'),
    path = require('path'),
    Util = require('js/util');

// Get all the Handlebars helpers.
require('js/templateHelpers');

module.exports = {

    tmplCache: window.ATOMIC_LACUNA_TEMPLATES || {},

    get: function(name) {
        // Get from cache or load new one.
        return this._get(name) || this.load(name);
    },

    _get: function(name) {
        var rv = Util.deepGet(this.tmplCache, name);
        return rv;
    },

    load: function(name) {
        if (window.ATOM_SHELL) {
            return this.save(name, this.compile(this.loadFile(name)));
        }
        else {
            // If it can't be gotten from the file system, then it isn't here.
            console.log(this.tmplCache); // Debug
            throw new Error('Template has not been loaded: ' + name);
        }
    },

    save: function(name, func) {
        Util.deepSet(this.tmplCache, name, func);
        return func;
    },

    compile: function(string) {
        string = string.replace(/\n/g, ''); // Remove newlines.
        string = string.replace(/\s{2,}/g, ''); // Weed out whitespace.
        return Handlebars.compile(string);
    },

    fixName: function(name) {
        name = name.replace(/\./g, path.sep);
        return name + '.hbs';
    },

    loadFile: function(name) {
        var fname = this.fixName(name);
        var location = path.join(Util.root(), 'templates', fname);
        return fs.readFileSync(location).toString();
    }
};
