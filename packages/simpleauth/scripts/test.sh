#!/bin/bash
set -e
DIR="$(cd `dirname $0`; pwd)"
pushd "$DIR"

# Install chrome driver
apt-get update && apt-get install -y chromium-chromedriver

cd ..
dotnet test Microsoft.TeamsFx.SimpleAuth.sln --filter TestCategory="P0"
popd

exit 0
