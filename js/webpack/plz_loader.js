// This is a loader which reads plz source files and writes them back
// where we expect them to be. It's loosely based on webpack's cache-loader
// but changed quite a bit for different circumstances.
//
// TODO(peterebden): Not sure if this should all be a loader; should the writing
//                   code be a plugin instead to catch emit events?

const fs = require('fs');
const path = require('path');
const process = require('process');
const loaderUtils = require('loader-utils');
const zlib = require("zlib");

function strip(path, prefix) {
    return path.startsWith(prefix) ? path.substr(prefix.length) : path;
}

function requestFilename(request) {
    return request.substr(request.lastIndexOf('!') + 1);
}

function loader(...args) {
    const callback = this.async();
    const opts = loaderUtils.getOptions(this) || {};
    const request = requestFilename(loaderUtils.getRemainingRequest(this));
    const filename = strip(request, opts.tmpDir);
    if (!opts.srcs.includes(filename)) {
	return callback(null, ...args);
    }
    const outFilename = strip(filename, opts.pkg) + '.json.gz';
    const dependencies = this.getDependencies()
	  .map(dep => strip(dep, opts.tmpDir))
	  .concat(this.loaders.map(l => l.path));
    zlib.gzip(JSON.stringify({
	dependencies: dependencies,
	contextDependencies: this.getContextDependencies(),
	result: args,
    }), (err, gzippedData) => {
	if (err) {
	    return callback(err, ...args);
	}
	fs.writeFile(outFilename, gzippedData, err => {
	    callback(err, ...args);
	});
    });
}

function pitch(remainingRequest, prevRequest, dataInput) {
    const callback = this.async();
    if (!remainingRequest.endsWith('.json.gz')) {
	return callback();
    }
    const request = requestFilename(remainingRequest);
    fs.readFile(request, (err, gzippedData) => {
	if (err) {
	    return callback(err);
	}
	zlib.gunzip(gzippedData, (err, uncompressedData) => {
	    if (err) {
		return callback(err);
	    }
	    const data = JSON.parse(uncompressedData);
	    data.dependencies.forEach(dep => this.addDependency(dep));
	    data.contextDependencies.forEach(dep => this.addContextDependency(dep));
	    callback(null, ...data.result);
	});
    });
}

module.exports = loader;
module.exports.pitch = pitch;
