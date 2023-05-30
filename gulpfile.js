const uswds = require("@uswds/compile");

/**
 * USWDS version
 * Set the version of USWDS you're using (2 or 3)
 */

uswds.settings.version = 3;

/**
 * Path settings
 * Set as many as you need
 */

uswds.paths.dist.css = './clubfed/clubfed/static/css';
uswds.paths.dist.img = './clubfed/clubfed/static/img';
uswds.paths.dist.fonts = './clubfed/clubfed/static/fonts';
uswds.paths.dist.js = './clubfed/clubfed/static/js';
uswds.paths.dist.sass = './clubfed/clubfed/static/sass';

/**
 * Exports
 * Add as many as you need
 */

exports.init = uswds.init;
exports.compile = uswds.compile;
exports.copyAssets = uswds.copyAssets;