#!/usr/bin/env bash
xsltproc --path voko-grundo/dtd:revo-fonto/cfg xsl/revohtml.xsl revo-fonto/revo/*.xml > output/vortaro.html
python split_html.py
for HTML in output/content*.html
do
    HTML_INFLECTED=$(echo $HTML | sed -e 's/content/inflected_content/')
    python add_inflections.py $HTML $HTML_INFLECTED
done
python generate_opf.py