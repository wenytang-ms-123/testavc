VAR=$(git tag --points-at HEAD | grep simple | grep rc)
if [ ! -z "$VAR" ]
then
    echo $VAR
fi