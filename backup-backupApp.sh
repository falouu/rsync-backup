#!/usr/bin/env bash

source catalogs.sh

mkdir -p "${dest}-app"
rsync -vaE . "${dest}-app"