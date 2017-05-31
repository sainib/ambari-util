#!/bin/sh

for h in `cat Hostdetail.txt`
do
ping $h | head -2 | tail -1 | awk '{ print $5 " "  $4 }' | sed -e 's/(//g' | sed -e 's/)//g' | sed -e 's/://g' >> .t.$$
mv hosts .hosts
cat .hosts >> .t.$$
mv .t.$$ hosts
done
