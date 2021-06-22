#!/usr/bin/env bash
for XML in revo-fonto/revo/*.xml
do
    RADIX=$(basename $XML .xml)
    echo $RADIX
    xsltproc -o output/${RADIX}.html --path voko-grundo/dtd:revo-fonto/cfg xsl/revohtml.xsl  ${XML}
done
