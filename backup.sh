#!/usr/bin/env bash

{
source catalog.sh


for src in "${srcs[@]}"
do
    echo "$src"
done

#rsync -vaRE --progress "${src}" "${dest}"





} 2> >(tee errors.txt) | tee log.txt