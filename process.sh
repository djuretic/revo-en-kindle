#!/usr/bin/env bash
xsltproc --path voko-grundo/dtd:revo-fonto/cfg xsl/revohtml.xsl revo-fonto/revo/*.xml > output/vortaro.html
python split_html.py
python generate_opf.py