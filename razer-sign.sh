#!/bin/bash

set -x 

DIR="$(dirname $(readlink -f $0))"
echo $DIR
cd "/lib/modules/$(uname -r)/updates"

xz -d razeraccessory.ko.xz
xz -d razerkbd.ko.xz
xz -d razerkraken.ko.xz
xz -d razermouse.ko.xz

KSCRIPTS="/usr/src/linux-obj/x86_64/default/scripts/"

$KSCRIPTS/sign-file sha256 "$DIR/MOK.priv" "$DIR/MOK.der" razeraccessory.ko
$KSCRIPTS/sign-file sha256 "$DIR/MOK.priv" "$DIR/MOK.der" razerkbd.ko
$KSCRIPTS/sign-file sha256 "$DIR/MOK.priv" "$DIR/MOK.der" razerkraken.ko
$KSCRIPTS/sign-file sha256 "$DIR/MOK.priv" "$DIR/MOK.der" razermouse.ko

xz -z razer*
