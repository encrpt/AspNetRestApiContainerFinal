#!/bin/sh

pwd
echo "[encrpt] wait for host $1 port $2"

./wait-for-it.sh $1:$2
# start app
dotnet AspNetRestApiContainer.WebApi.dll
