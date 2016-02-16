#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

date=$(date "+%Y-%m-%dT%H:%M:%S")
{

source "${DIR}/catalogs.sh"

echo ">>>>: Starting backup. Destination dir: '${dest}'"
mkdir -p "${dest}"

for src in "${srcs[@]}"
do
    echo ">>>>: Starting backup of: ${src}"
    rsync -vaRE "${src}" "${dest}"
    echo ">>>>: Succesfull backup of: ${src}"
done

echo ">>>>: BACKUP DONE!"

} 2> >(tee "${DIR}/errors-${date}.txt") | tee "${DIR}/log-${date}.txt"