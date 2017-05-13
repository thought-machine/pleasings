const path = require('path');
const process = require('process');
const webpack = require('webpack');
const ClosureCompilerPlugin = require('webpack-closure-compiler');

module.exports = {
    entry: process.env.SRCS.split(' '),
    output: {
	path: path.dirname(process.env.OUT),
        filename: path.basename(process.env.OUT),
    },
    module: {
	rules: [
	    {test: /\.(js|jsx)$/, use: 'babel-loader'}
	]
    },
    plugins: [
        new ClosureCompilerPlugin({
          compiler: {
            language_in: 'ECMASCRIPT6',
            language_out: 'ECMASCRIPT5',
            compilation_level: 'ADVANCED'
          },
          concurrency: 3,
        })
    ]
};
