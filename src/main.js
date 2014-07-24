'use strict';

var app = require('app');
var BrowserWindow = require('browser-window');
var fs = require('fs');
var path = require('path');
var ipc = require('ipc');

var Handlebars = require('handlebars');
var development = process.env.ATOMIC_LACUNA_DEVELOPMENT || false;

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is GCed.
var mainWindow = null;

// Quit when all windows are closed.
app.on('window-all-closed', function () {
    if (process.platform !== 'darwin') {
        app.quit();
    }
});

// This method will be called when atom-shell has done all required
// initialization and is ready to create browser windows.
app.on('ready', function () {
    mainWindow = new BrowserWindow({width: 800, height: 600, show: false});
    mainWindow.maximize();
    mainWindow.loadUrl('file://' + doIndexStuff());
    mainWindow.on('closed', function() {
        mainWindow = null;
    });
});

ipc.on('atomic-lacuna-window-show', function () {
    mainWindow.show();
});


// Method to run the Handlebars template for the index.html file and return the
// url to the a file generated from this template.
function doIndexStuff() {
    var template = getIndexTemplate();
    var args = {
        development : development,
        atomShell : true // If this script is running, we're starting the atom-shell.
    };

    // Figure location
    var location = '';
    if (development) {
        location = path.join(__dirname, '..', 'public', 'index-compiled.html');
    } else {
        location = path.join(__dirname, 'index-compiled.html');
    }

    fs.writeFileSync(location, template(args));
    return location;
};

function getIndexTemplate() {
    return Handlebars.compile(fs.readFileSync(getIndexTemplatePath()).toString());
}

function getIndexTemplatePath() {
    if (development) {
        return path.join(__dirname, '..', 'public', 'index-template.html');
    }

    return path.join(__dirname, 'index-template.html');
}
