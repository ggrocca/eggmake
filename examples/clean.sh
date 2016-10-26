#!/usr/bin/env bash

for dir in ./*; do
    if [ -d $dir ]; then
	cd $dir
	gmake clean
	if (( $? != 0 )); then
	    echo ""
	    echo "Error while cleaning $dir."
	    echo
	    exit 1
	fi
	cd ..
    fi
done
