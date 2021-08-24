#!/bin/bash
countNum=1000
# sleep 100
restUrl="https://dev.azure.com/mseng/VSIoT/_apis/pipelines/11303/runs?api-version=6.0-preview.1"
echo "============ step1" 

rsp=$(curl -u :$1 $restUrl)
rsp=$(echo $rsp| jq -r '.value| .[0]')
status=$(echo $rsp | jq -r '.state')
buildId=$(echo $rsp | jq -r '.id')

while [[ $countNum -le 5000 && "$status" != "completed" ]]
do 
    sleep $countNum
    status=$(curl -u :$1 $restUrl | jq -r '.state')
    echo "=========== step2"
    countNum=$(( $countNum + 1000 ))
done
if [[ "$status" != "completed" ]]
then
exit 1
fi

restUrl="https://dev.azure.com/mseng/VSIoT/_apis/build/builds/$buildId/artifacts?api-version=6.0"
asset_id=$(curl -u :$1 $restUrl | jq '.value |.[] | .resource' |jq '.data' | tr -d -c 0-9)
echo "=============== step3"
echo $restUrl
echo $asset_id