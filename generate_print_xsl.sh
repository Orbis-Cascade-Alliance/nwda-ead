#!/bin/sh
for i in nwda*.xsl; do 
java -jar process/saxon9.jar -xsl:process/html-to-fo.xsl -s:$i -o:print/$i; 
echo "Processing $i";
done