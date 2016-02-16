#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

date=$(date "+%Y-%m-%dT%H:%M:%S")

while getopts "f" o; do
    case "${o}" in
        f)
            no_restored_copy=true
            ;;
        *)
            ;;
    esac
done

if [[ "$?" != 0 ]]
then
	echo ">>>>: invalid options! Aborting..." 1>&2
	exit 1
fi
shift $((OPTIND-1))

{
source "${DIR}/catalogs.sh"

src="$1"
rdest="$2"

if [ -z "$src" ];
then
	echo ">>>>: source path empty! Specify source path in first parameter!" 1>&2
	exit 1
fi

if [ -z "$rdest" ];
then
	echo ">>>>: dest path empty! Specify dest path in second parameter!"
	exit 1
fi


if [ ! -d "${restored_dir}" ];
then
	echo ">>>>: restored dir not exists! Aborting" 1>&2
	exit 1
fi

echo ">>>>: restoring '$src'. Restored copy will be saved in '${restored_dir}'"
rsync -vaRE --omit-dir-times "${src}" "${rdest}"

exit_code="$?"
if [[ "${exit_code}" != 0 ]]
then
	echo ">>>>: Restoring failed! O_o. Rsync exit code: ${exit_code}. Aborting..." 1>&2
	exit 1
fi

echo ">>>>: restoring completed."

if [ "${no_restored_copy}" != "true" ]; then
	echo ">>>>: Saving restored copy..."
	rsync -vaRE "$src" "${restored_dir}"


	if [[ "$?" != 0 ]]
	then
		echo ">>>>: Saving Restored copy failed ! O_o. Aborting..." 1>&2
		exit 1
	fi
else
	echo ">>>>: Don't saving restored copy - as requested"
fi

echo ">>>>: deleting restored files from backup..."
rm -rf "$src"

} 2> >(tee "${DIR}/restoring-errors-${date}.txt") | tee "${DIR}/restoring-log-${date}.txt"