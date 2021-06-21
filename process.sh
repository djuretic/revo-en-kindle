#!/usr/bin/env bash
for XML in abel kaj
do
    xsltproc -o output/${XML}.html --path voko-grundo/dtd:revo-fonto/cfg xsl/revohtml.xsl  revo-fonto/revo/${XML}.xml
done
