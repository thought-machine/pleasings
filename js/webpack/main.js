const process = require('process');
const webpack = require('webpack');
const WebPackConfig = require('./config.js');

webpack(WebPackConfig, function(err, stats) {
    if (err) {
	console.error(err.stack || err);
	if (err.details) {
	    console.error(err.details);
	}
	process.exit(1);
    }
    const info = stats.toJson();
    if (stats.hasErrors()) {
	console.error(info.errors.join('\n'));
	process.exit(1);
    }
    if (stats.hasWarnings()) {
	console.warn(info.warnings.join('\n'));
    }
})
