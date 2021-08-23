#!/bin/bash
countNum=1000
restUrl="https://dev.azure.com/mseng/VSIoT/_apis/build/latest/$2?api-version=6.0-preview.1"
rsp=$(curl -u :$1 $restUrl)
status=$(echo $rsp | jq -r '.status')
buildId=$(echo $rsp | jq -r '.buildNumber')

while [[ $countNum -le 5000 && "$status" != "completed" ]]
do 
    sleep $countNum
    status=$(curl -u :$1 $restUrl | jq -r '.status')
    countNum=$(( $countNum + 1000 ))
done
if [[ "$status" != "completed" ]]
then
exit 1
fi

restUrl="https://dev.azure.com/mseng/VSIoT/_apis/build/builds/$buildId/artifacts?api-version=6.0"
asset_id=$(curl -u :$1 $restUrl | jq '.value |.[] | .resource' |jq '.data' | tr -d -c 0-9)
echo $asset_id