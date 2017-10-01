const process = require('process');
const webpack = require('webpack');
const WebPackConfig = require('./config.js');

webpack(WebPackConfig({
    srcs: process.env.SRCS_JS.split(' '),
    out: process.env.OUTS_JS,
    srcsManifest: process.env.SRCS_MANIFEST ? process.env.SRCS_MANIFEST.split(' ') : [],
    srcsDll: process.env.SRCS_DLL ? process.env.SRCS_DLL.split(' ') : [],
    outManifest: process.env.OUTS_MANIFEST,
    tmpDir: process.env.TMP_DIR,
    buildConfig: process.env.BUILD_CONFIG,

}), function(err, stats) {
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
