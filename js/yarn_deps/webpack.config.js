const webpack = require('webpack');

module.exports = {
    entry: {
        yarnDeps: ['./index'],
    },
    output: {
        filename: 'yarn_deps.js',
        path:  __dirname,
        library: '[name]',
    },
    plugins: [
        new webpack.BannerPlugin({ banner: "#!/usr/bin/env node", raw: true }),
    ],
    mode: "production",
    target: 'node'
};