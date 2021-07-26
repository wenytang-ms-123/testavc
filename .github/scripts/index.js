var pkg = require('../../package.json')

updateLocalDependency(resolved, depVersion, savePrefix) {
    const depName = resolved.name;

    // first, try runtime dependencies
    let depCollection = this.dependencies;

    // try optionalDependencies if that didn't work
    if (!depCollection || !depCollection[depName]) {
        depCollection = this.optionalDependencies;
    }

    // fall back to devDependencies
    if (!depCollection || !depCollection[depName]) {
        depCollection = this.devDependencies;
    }

    if (resolved.registry || resolved.type === "directory") {
        // a version (1.2.3) OR range (^1.2.3) OR directory (file:../foo-pkg)
        depCollection[depName] = `${savePrefix}${depVersion}`;
    } else if (resolved.gitCommittish) {
        // a git url with matching committish (#v1.2.3 or #1.2.3)
        const [tagPrefix] = /^\D*/.exec(resolved.gitCommittish);

        // update committish
        const { hosted } = resolved; // take that, lint!
        hosted.committish = `${tagPrefix}${depVersion}`;

        // always serialize the full url (identical to previous resolved.saveSpec)
        depCollection[depName] = hosted.toString({ noGitPlus: false, noCommittish: false });
    } else if (resolved.gitRange) {
        // a git url with matching gitRange (#semver:^1.2.3)
        const { hosted } = resolved; // take that, lint!
        hosted.committish = `semver:${savePrefix}${depVersion}`;

        // always serialize the full url (identical to previous resolved.saveSpec)
        depCollection[depName] = hosted.toString({ noGitPlus: false, noCommittish: false });
    }
}