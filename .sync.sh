#!/bin/bash

if [[ -f .env ]]
then
    export $(cat .env | grep CONTAINER_SYNC_ | sed 's/#.*//g' | xargs)
fi

if [[ $CONTAINER_SYNC_NAME == '' ]]
then
  echo "CONTAINER_SYNC_NAME is missing in your .env project file"
  echo "Please try to define it like this : CONTAINER_SYNC_NAME=php"
  exit
fi

if [[ $CONTAINER_SYNC_ROOT == '' ]]
then
  echo "$CONTAINER_SYNC_ROOT is missing in your .env project file"
  echo "Please try to define it like this : CONTAINER_SYNC_ROOT=/usr/src/app"
  exit
fi

container_id=`docker ps  -q -f "name=${CONTAINER_SYNC_NAME}"`
if [[ $container_id == '' ]]
then
  echo "Docker container is missing."
  echo "Please verify that your php instance is running"
  exit
fi

dirs=$@
if [[ $dirs == '' ]]
then
  echo "You should specify at least one directory as argument of this script"
  exit
fi

echo "Sync. container (id=${container_id}) with ${dirs} directory(ies)"

for dir in $dirs
do
  if [[ $dir != 'vendor' && $dir != 'var' && $dir != 'vendor/' && $dir != 'var/' ]]
  then
    echo $dir is not a valid directory
    echo Only vendo and var are allowed
    exit
  fi

  echo -ne $dir... \\t\\t...
  rm -rf ./${dir}/*
  echo -ne purged... \\t\\t...
  docker cp $container_id:${CONTAINER_SYNC_ROOT}/${dir} .
  echo "synchronized !"

done

exit