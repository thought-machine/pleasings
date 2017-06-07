const path = require('path');
const process = require('process');
const webpack = require('webpack');
const ClosureCompilerPlugin = require('webpack-closure-compiler');

// Map plz's standard build config names to something meaningful to webpack.
const buildConfig = process.env.BUILD_CONFIG;
const nodeEnv = buildConfig === 'opt' ? 'production' : 'development';

let plugins = [
    new webpack.DefinePlugin({
	'process.env': {
	    NODE_ENV: JSON.stringify(nodeEnv)
	}
    }),
    new ClosureCompilerPlugin({
        compiler: {
            language_in: 'ECMASCRIPT6',
            language_out: 'ECMASCRIPT5',
        },
        concurrency: 3,
    })
]

let entry = process.env.SRCS_JS.split(' ').map(src => './' + src);
let library = undefined;
if (process.env.OUTS_MANIFEST) {
    // We are building a vendor bundle,
    const name = path.basename(process.env.OUTS_JS, '.js');
    entry = {[name]: process.env.SRCS_JS.split(' ')};
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
	manifest: require(manifests[i]),
    })));
}

module.exports = {
    entry: entry,
    output: {
	path: process.env.TMP_DIR,
        filename: path.basename(process.env.OUTS_JS),
	library: library,
    },
    module: {
	rules: [{
	    test: /\.(js|jsx)$/,
      loader: 'babel-loader',
      query: {
        presets: [
          'es2015',
          'react'
        ],
        plugins: []
      },
	}]
    },
    resolve: {
	modules: process.env.NODE_PATH.split(':'),
    },
    resolveLoader: {
	modules: process.env.NODE_PATH.split(':'),
    },
    plugins: plugins,
};
