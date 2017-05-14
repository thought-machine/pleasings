const path = require('path');
const process = require('process');
const webpack = require('webpack');
const ClosureCompilerPlugin = require('webpack-closure-compiler');

// Map plz's standard build config names to something meaningful to webpack.
const buildConfig = process.env.BUILD_CONFIG;
const nodeEnv = buildConfig === 'opt' ? 'production' : 'development';

module.exports = {
    entry: process.env.SRCS.split(' ').map(src => './' + src),
    output: {
	path: path.dirname(process.env.OUT),
        filename: path.basename(process.env.OUT),
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
    plugins: [
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
};
