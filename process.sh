#!/usr/bin/env bash
echo "Transformi per XSLT"
xsltproc --path voko-grundo/dtd:revo-fonto/cfg xsl/revohtml.xsl revo-fonto/revo/*.xml > output/vortaro.html
echo "Dividi la grandan dosieron"
python split_html.py
echo "Aldoni la infleksiojn"
for HTML in output/content*.html
do
    HTML_INFLECTED=$(echo $HTML | sed -e 's/content/inflected_content/')
    python add_inflections.py $HTML $HTML_INFLECTED
done
echo "Krei la .opf dosieron"
python generate_opf.py