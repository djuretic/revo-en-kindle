#!/usr/bin/env bash
XML=abel
xsltproc -o ${XML}.html --path voko-grundo/dtd:revo-fonto/cfg xsl/revohtml.xsl  revo-fonto/revo/${XML}.xml
# xsltproc -o ${XML}1.html --path voko-grundo/dtd:revo-fonto/cfg voko-grundo/xsl/revohtml1.xsl  revo-fonto/revo/${XML}.xml
# xsltproc -o ${XML}2.html --path voko-grundo/dtd:revo-fonto/cfg voko-grundo/xsl/revohtml2.xsl  revo-fonto/revo/${XML}.xml