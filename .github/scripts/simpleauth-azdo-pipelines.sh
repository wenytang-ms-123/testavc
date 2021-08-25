#!/bin/bash
countNum=1
# sleep 100
restUrl="https://dev.azure.com/mseng/VSIoT/_apis/pipelines/$2/runs?api-version=6.0-preview.1"

rsp=$(curl -u :$1 $restUrl | jq -r '.value| .[0]')
status=$(echo $rsp | jq -r '.state')
buildId=$(echo $rsp | jq -r '.id')
while [[ $countNum -le 50 && "$status" != "completed" ]]
do 
    sleep 1m
    rsp=$(curl -u :$1 $restUrl | jq -r '.value| .[0]')
    status=$(echo $rsp | jq -r '.state')
    countNum=$(( $countNum + 1 ))
done
if [[ "$status" != "completed" ]]
then
exit 1
fi
echo "------step2"
restUrl="https://dev.azure.com/mseng/VSIoT/_apis/build/builds/$buildId/artifacts?api-version=6.0"
asset_rsp=$(curl -u :$1 $restUrl)
echo $asset_rsp
asset_id=$(echo $asset_rsp | jq '.value |.[] | .resource' |jq '.data' | tr -d -c 0-9)
echo $asset_id