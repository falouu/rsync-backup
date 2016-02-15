#!/usr/bin/env bash

date=$(date "+%Y-%m-%dT%H:%M:%S")
{

source catalogs.sh

echo ">>>>: Starting backup. Destination dir: '${dest}'"
mkdir -p "${dest}"

for src in "${srcs[@]}"
do
    echo ">>>>: Starting backup of: ${src}"
    #rsync -vaRE --progress "${src}" "${dest}"
    rsync -vaRE "${src}" "${dest}"
    echo ">>>>: Succesfull backup of: ${src}"
done

echo ">>>>: BACKUP DONE!"

} 2> >(tee errors-${date}.txt) | tee log-${date}.txt