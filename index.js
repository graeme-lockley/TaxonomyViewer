'use strict';

var Elm = require('./src/elm/Main.elm');
var mountNode = document.getElementById('elm-app');

// The third value on embed are the initial values for incoming ports into Elm
var app = Elm.Main.embed(mountNode);