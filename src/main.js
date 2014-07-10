var app = require('app'); // Module to control application life.
var BrowserWindow = require('browser-window'); // Module to create native browser window.
var fs = require('fs');
var path = require('path');

var Handlebars = require('handlebars');
var development = process.env.ATOMIC_LACUNA_DEVELOPMENT || false;

// Report crashes to our server.
require('crash-reporter').start();

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the javascript object is GCed.
var mainWindow = null;

// Quit when all windows are closed.
app.on('window-all-closed', function () {
    if (process.platform != 'darwin') {
        app.quit();
    }
});

// This method will be called when atom-shell has done everything
// initialization and ready for creating browser windows.
app.on('ready', function () {

    // Create the browser window.
    mainWindow = new BrowserWindow({width: 800, height: 600});
    mainWindow.maximize();

    // and load the index.html of the app.
    mainWindow.loadUrl('file://' + doIndexStuff());

    // Emitted when the window is closed.
    mainWindow.on('closed', function() {
        // Dereference the window object, usually you would store windows
        // in an array if your app supports multi windows, this is the time
        // when you should delete the corresponding element.
        mainWindow = null;
    });
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
