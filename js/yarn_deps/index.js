const fs = require('fs');
const parse = require('parse-yarn-lock').default
const semver = require('semver')

// A map of version requirements to a lockfile entry
let locks = parse(fs.readFileSync("/dev/stdin", {encoding: 'utf8'})).object
function getLockEntry(name, requirement) {
    return locks[`${name}@${requirement}`]
}

// A map of resolved versions to their lockfile entries
let versionLockEntry = {}
function getVersionLockEntry(name, version) {
    return versionLockEntry[`${name}@${version}`]
}

// A map of module names to a list of available versions
let packageVersions = {}

// Returns the module name from a version requirement
function getName(key) {
    let nameVer = key.split("@")
    if(key.startsWith("@")) {
        return `@${nameVer[1]}`
    }
    return nameVer[0]
}

// formats a yarn rule to download the module
function formatYarnRule(name, resolvedBy, out, version, deps) {
    if (deps.length === 0) {
        console.log(`
yarn_module(
    name = '${name}',
    out = '${out}',
    resolved_by = '${resolvedBy}',
    version = '${version}',
)`
        )
    } else {
        let formattedDeps = []
        deps.forEach(function (dep) {
            let formattedDep = `        ":_${dep}#download"`
            if(!formattedDeps.includes(formattedDep)) {
                formattedDeps.push(formattedDep)
            }
        })

        console.log(`
yarn_module(
    name = '${name}',
    out = '${out}',
    resolved_by = '${resolvedBy}',
    version = '${version}',
    deps = [
${formattedDeps.sort().join(",\n")},
    ],
)`
        )
    }
}

// Formats a module name and version to the correct please rule name
function getRuleNameForDep(name, version) {
    let versions = packageVersions[name]
    name = name.replace("/", "-")

    // If there is some version for this dependency greater than this version, add the version number to the rule name
    // assuming this will only be depended on by other module rules
    if(versions.some(function (ver) {
        return semver.gt(ver, version)
    })) {
        return `${name}-${version}`
    }
    // Otherwise we are the latest version, use the raw name so others can depend on us easily
    return name
}

// Resolves a dependency requirement to a build rule
function resolveDependency(name, requirement) {
    return getRuleNameForDep(name, locks[`${name}@${requirement}`].version)
}

// Resolves a dependency requirement to a list of modules rules that are transitively required
function resolveTransitiveDependencies(name, requirement, seen = new Set()) {
    // Avoid cycles
    if (seen.has(name + requirement)) {
        return []
    }
    seen.add(name + requirement)

    let lockEntry = getLockEntry(name, requirement)

    let deps = [resolveDependency(name, requirement)]

    if (lockEntry.dependencies !== undefined) {
        let transitiveDeps = Object.keys(lockEntry.dependencies).flatMap(function (name) {
            let requirement = lockEntry.dependencies[name]
            return resolveTransitiveDependencies(name, requirement, seen)
        })
        deps.push(...transitiveDeps)
    }
    if (lockEntry.optionalDependencies !== undefined) {
        let transitiveDeps = Object.keys(lockEntry.optionalDependencies).flatMap(function (name) {
            let requirement = lockEntry.optionalDependencies[name]
            return resolveTransitiveDependencies(name, requirement, seen)
        })
        deps.push(...transitiveDeps)
    }
    return deps
}

function generateYarnRule(name, version, versions) {
    let lockfileEntry = getVersionLockEntry(name, version)
    let ruleName = getRuleNameForDep(name, lockfileEntry.version, versions)

    let deps = []
    if (lockfileEntry.dependencies !== undefined) {
        deps = Object.keys(lockfileEntry.dependencies).flatMap(function (name) {
            let requirement = lockfileEntry.dependencies[name]
            return resolveTransitiveDependencies(name, requirement)
        })
    }
    if (lockfileEntry.optionalDependencies !== undefined) {
        Object.keys(lockfileEntry.optionalDependencies).forEach(function (name) {
            let requirement = lockfileEntry.optionalDependencies[name]
            deps.push(...resolveTransitiveDependencies(name, requirement))
        })
    }
    formatYarnRule(ruleName, lockfileEntry.resolved, `${name}-${lockfileEntry.version}.tgz`.replace("/", "-"), lockfileEntry.version, deps)
}

// Find out what versions of each lib we have installed
Object.keys(locks).forEach(function (key) {
    let name = getName(key)

    let versions = packageVersions[name]
    if (!versions) {
        versions = []
    }

    let version = locks[key].version
    if (!versions.includes(version)) {
        let resolution = `${name}@${version}`
        versionLockEntry[resolution] = locks[key]
        versions.push(version)
    }

    packageVersions[name] = versions
})

// TODO(jpoole): we could deal with files and generate a unit test to check the yarn.lock hash hasn't changed
// since the last time this was run
console.log("# This file was autogenerated by ///pleasings//js/yard_deps:run from a yarn.lock file. Do not modify.\n")
console.log("subinclude('//js:yarn')")
console.log("package(default_visibility = ['PUBLIC'])\n")

// Generate a yarn rule for each unique module version
Object.keys(packageVersions).forEach(function (name) {
    let versions = packageVersions[name]
    versions.forEach(function (version) {
        generateYarnRule(name, version, versions)
    })
})
