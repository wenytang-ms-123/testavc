const fs = require("fs");
var path = require("path");
const loadJsonFile = require("load-json-file");
const writePkg = require("write-pkg");
const semver = require("semver");

const sdk_version = require(path.join(__dirname, "../package.json")).version;
const sdk_name = require(path.join(__dirname, "../package.json")).name;
console.log("hello")
function listFile(dir, list = []) {
  var arr = fs.readdirSync(dir);
  arr.forEach(function (item) {
    var fullpath = path.join(dir, item);
    var stats = fs.statSync(fullpath);
    if (item === "node_modules") return list;
    if (stats.isDirectory()) {
      listFile(fullpath, list);
    } else {
      if (item === "package.json") list.push(fullpath);
    }
  });
  return list;
}

const template_dir = path.join(__dirname, "../../../templates/");
const dep_pkgs = listFile(template_dir);
let change = false;
for (file of dep_pkgs) {
  let pkg_ = loadJsonFile.sync(file);
  let dep = pkg_.dependencies;
  if (dep) {
    let dep_map = new Map(Object.entries(dep));
    if (dep_map.get(sdk_name)) {
      if (semver.prerelease(sdk_version)) {
        dep_map.set(sdk_name, sdk_version);
      } else if (!semver.intersects(dep_map.get(sdk_name), sdk_version)) {
        dep_map.set(sdk_name, `^${sdk_version}`);
      } else {
          continue;
      }
      change = true;
      pkg_.dependencies = Object.fromEntries(dep_map);
      writePkg(file, pkg_);
    }
  }
}

if(change) {
    let file = path.join(template_dir, "package.json")
    console.log('path======', file);
    let pkg_ = loadJsonFile.sync(file);
    let ver = pkg_.version;
    ver = semver.inc(ver, "patch");
    console.log('ver ====', ver)
    pkg_.version = ver;
    writePkg(file, pkg_);
}
