const fs = require('fs');
const path = require('path');
const webpack = require('webpack');
const requireDynamic = require('./require_dynamic.js');
const BabelPresetES2015 = require('babel-preset-es2015');
const BabelPresetReact = require('babel-preset-react');

module.exports = function(opts) {
    const library = opts.outManifest ? path.basename(opts.out, '.js') : undefined;

    return {
	entry: opts.srcs.map(src => './' + src),
	output: {
	    path: opts.tmpDir,
            filename: path.basename(opts.out),
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
		opts.tmpDir,
		path.join(opts.tmpDir, 'third_party/js'),
	    ],
	},
	plugins: [
	    new webpack.DefinePlugin({
		'process.env': {
		    // Map plz's standard build config names to something meaningful to webpack.
		    NODE_ENV: JSON.stringify(opts.buildConfig === 'opt' ? 'production' : 'development')
		}
	    }),
	    ...opts.srcsDll.map((dll, i) => new webpack.DllReferencePlugin({
		name: path.basename(dll, '.js'),
		manifest: JSON.parse(fs.readFileSync(opts.srcsManifest[i], 'utf8')),
	    })),
	    ...(opts.outManifest ? [new webpack.DllPlugin({
		name: library,
		path: path.join(opts.tmpDir, opts.outManifest)
	    })] : []),
	]
    };

};
