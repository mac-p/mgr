#!/bin/bash

VER='/opt/dev-uppaal/bin-Linux/verifyta'
DEFOPTS='-s -u'

if [ $# -lt 4 ]
then
    echo "Script should be run with at least two arguments"
    exit 1
fi

model_file=$1
shift
prop_file=$1
shift
ver_out=$1
shift
stat_out=$1
shift

timestart=`date +%s`
$VER $DEFOPTS $model_file $prop_file $@ >$ver_out &
verpid=$!
top -b -d1.00 -p $verpid >$stat_out &
toppid=$!

wait $verpid
timefin=`date +%s`
kill -2 $toppid

echo "$timestart $timefin verifyta" >> $stat_out

grep "verifyta" $stat_out | tail -n 2 > "$stat_out.tmp"
mv "$stat_out.tmp" $stat_out

