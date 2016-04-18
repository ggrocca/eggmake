#!/bin/bash

cat << EOF > azang.tab.cc
#include "azang.tab.hh"
#include <stdio.h>

void azang()
{
    printf ("Azang!\n");
}
EOF
