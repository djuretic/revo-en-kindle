from pathlib import Path

HTML_CONTENT_BEFORE = """<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:idx="www.mobipocket.com" xmlns:mbp="www.mobipocket.com" xmlns:xlink="http://www.w3.org/1999/xlink">
  <head>
    <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
  </head>
  <body>
    <mbp:pagebreak/>
    <mbp:frameset>
      <mbp:slave-frame display="bottom" device="all" breadth="auto" leftmargin="0" rightmargin="0" bottommargin="0" topmargin="0">
        <div align="center" bgcolor="yellow">
          <a onclick="index_search()">Dictionary Search</a>
        </div>
      </mbp:slave-frame>
      <mbp:pagebreak/>
"""

HTML_CONTENT_AFTER = """      </mbp:frameset>
  </body>
</html>"""

def chunker(seq, size):
    return [seq[pos:pos + size] for pos in range(0, len(seq), size)]

def main():
    with open('template.html') as f:
        lines = f.readlines()
    
    html_dir = Path('./output')
    html_files = list(html_dir.glob("*.html"))
    html_files.sort()

    splits = chunker(html_files, 100)
    
    for n, split in enumerate(splits):
        with open(f'output/content{n}.html', 'w') as f:
            f.write(HTML_CONTENT_BEFORE)
            for html_file in split:
                with open(html_file, 'r') as infile:
                    f.write(infile.read())
                # TODO pagebreak?
            f.write(HTML_CONTENT_AFTER)


if __name__ == "__main__":
    main()