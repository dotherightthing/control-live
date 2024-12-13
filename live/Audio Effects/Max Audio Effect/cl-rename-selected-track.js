/* exported bang, loadbang, renameSelectedTrack */
/* global getSelectedTrackObj, log */

const console = {};
const lib = {};

// https://docs.cycling74.com/max8/vignettes/jsrequire
// Unsure how to work with Max search path so using includes rather than modules for now

include('_cl-get-selected-track-obj.js', lib);
include('_cl-log.js', console);
include('_cl-string.polyfill.js');

// const getSelectedTrackObj = require('_getSelectedTrackObj');
// const log = require('_log');

// inlets and outlets
inlets = 1;
outlets = 1;

// local functions and variables
console.local = 1;
lib.local = 1;

// global functions and variables

/**
 * @function bang
 * @summary Runs automatically when 'live.thisdevice' left outlet is connected to 'js script-name.js' inlet
 */
function bang() { // eslint-disable-line no-unused-vars
    // this_device = the Max for Live Device object that contains this JavaScript code
    // in the max object, live.thisdevice determines when the Max Device has completely loaded
    // and sends a bang from its left outlet when the Device is fully initialized, including the Live API).
}

/**
 * @function loadbang
 * @summary Executes when the Max patch opens
 */
function loadbang() {
    console.log('cl-rename-selected-track initialized.'); // eslint-disable-line no-console
}

/**
 * @function renameSelectedTrack
 * @summary Rename the selected track
 * @param {string} trackName Track name
 */
function renameSelectedTrack(trackName) {
    const trackObj = new LiveAPI('live_set view selected_track');
    const selectedTrackObj = lib.getSelectedTrackObj(trackObj);

    if (typeof selectedTrackObj === 'object') {
        selectedTrackObj.set('name', trackName);
    }
}
