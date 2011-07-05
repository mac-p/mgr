#!/bin/bash

VER='/opt/dev-uppaal/bin-Linux/verifyta'
DEFOPTS='-s -u'

if [ $# -lt 2 ]
then
    echo "Script should be run with at least two arguments"
    exit 1
fi

model=$1
shift
num=$1
shift

model_file="$model.xml"
verdir="$model.ver"
propfile="$verdir/$num.q"
verout="$verdir/$num.ver"
statout="$verdir/$num.stats"

timestart=`date +%s`
$VER $DEFOPTS $model_file $propfile $@ >$verout &
verpid=$!
top -b -d1.00 -p $verpid >$statout &
toppid=$!

wait $verpid
timefin=`date +%s`
kill -2 $toppid

echo "$timestart $timefin verifyta" >> $statout

grep "verifyta" $statout | tail -n 2 > "$statout.tmp"
mv "$statout.tmp" $statout

