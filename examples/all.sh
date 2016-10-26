#!/usr/bin/env bash

for dir in ./*; do
    if [ -d $dir ]; then
	cd $dir
	gmake
	if (( $? != 0 )); then
	    echo ""
	    echo "Example $dir is BROKEN."
	    echo
	    exit 1
	fi
	cd ..
    fi
done
