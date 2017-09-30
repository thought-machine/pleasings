// Using this to route specific require() calls through a custom module of
// our own which can handle a few specific dynamic requires. This solves
// bundling of Webpack loaders and so forth in a fairly rough-and-ready way.

const process = require('process');
const babelLoader = require('babel-loader');
const jsonLoader = require('json-loader');

// Somewhat dodgy promisifying follows.
// TODO(peterebden): Should use something better; either Node (but we don't want to
//                   require node 8 yet) or Bluebird (but that didn't seem to work
//                   on the first attempt).
const promisify = function(loader) {
    const ret = {
	catch: function(callback) {
	    if (!loader) {
		throw 'Unknown dynamic require path ' + path;
	    }
	    return ret;
	},
	then: function(callback) {
	    callback(loader);
	}
    };
    return ret;
};

const knownPackages = {
    'babel-loader': promisify(babelLoader),
    'json-loader': promisify(jsonLoader),
};


const KnownImportResolver = {
    apply: function(resolver) {
	resolver.plugin('module', function(request, callback) {
	    const loader = knownPackages[request.request];
	    if (loader) {
		callback(null, {
		    'path': request.request,
		    'data': loader
		});
	    }
	});
    }
};

const resolve = function(path) {
    const loader = knownPackages[path];
    if (!loader) {
	console.trace('Unknown dynamic require path ' + path);
	process.exit(1);
    }
    return loader;
};

module.exports = {
    // This is the replacement expression that will fetch this module
    requireExpr: 'require("js/webpack/require_dynamic.js")',
    // This is the replacement for require(). It only knows about a few modules.
    dynamicRequire: resolve,
    // Webpack resolver for the same.
    Resolver: KnownImportResolver
};
