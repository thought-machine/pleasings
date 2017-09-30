const fs = require('fs');
const path = require('path');
const process = require('process');
const webpack = require('webpack');
const requireDynamic = require('./require_dynamic.js');
const BabelPresetES2015 = require('babel-preset-es2015');
const BabelPresetReact = require('babel-preset-react');


// Map plz's standard build config names to something meaningful to webpack.
const buildConfig = process.env.BUILD_CONFIG;
const nodeEnv = buildConfig === 'opt' ? 'production' : 'development';

let plugins = [
    new webpack.DefinePlugin({
	'process.env': {
	    NODE_ENV: JSON.stringify(nodeEnv)
	}
    }),
];

let entry = process.env.SRCS_JS.split(' ').map(src => './' + src);
let library = undefined;
if (process.env.OUTS_MANIFEST) {
    // We are building a vendor bundle,
    const name = path.basename(process.env.OUTS_JS, '.js');
    library = name;
    plugins.push(new webpack.DllPlugin({
        name: name,
        path: path.join(process.env.TMP_DIR, process.env.OUTS_MANIFEST)
    }));
} else if (process.env.SRCS_DLL) {
    // We have some vendor DLLs to link to.
    const dlls = process.env.SRCS_DLL.split(' ');
    const manifests = process.env.SRCS_MANIFEST.split(' ');
    plugins = plugins.concat(dlls.map((dll, i) => new webpack.DllReferencePlugin({
	name: path.basename(dll, '.js'),
	manifest: JSON.parse(fs.readFileSync(manifests[i], 'utf8')),
    })));
}

// Symlink this guy into place. For some reason it never seems to work to just add to modules.
fs.symlinkSync(process.env.TOOLS_WEBPACK + '.buildin', process.env.TMP_DIR + '/buildin');

module.exports = {
    entry: entry,
    output: {
	path: process.env.TMP_DIR,
        filename: path.basename(process.env.OUTS_JS),
	library: library,
    },
    module: {
	rules: [{
	    test: /\.json$/,
	    use: [{ loader: 'json-loader' }],
	}, {
	    test: /\.(js|jsx)$/,
	    use: [
		{
		    loader: 'babel-loader',
		    options: {
			babelrc: false,
			presets: [
			    BabelPresetES2015,
			    BabelPresetReact,
			],
		    },
		}
	    ],
	}]
    },
    node: {
	process: false,
	Buffer: false,
    },
    resolveLoader: {
	plugins: [requireDynamic.Resolver],
    },
    resolve: {
	modules: [
	    process.env.TMP_DIR,
	    path.join(process.env.TMP_DIR, 'third_party/js'),
	],
    },
    plugins: plugins,
};
