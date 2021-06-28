from pathlib import Path

HTML_CONTENT_BEFORE = """<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:idx="www.mobipocket.com" xmlns:mbp="www.mobipocket.com" xmlns:xlink="http://www.w3.org/1999/xlink">
  <head>
    <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
  </head>
  <body>
    <mbp:pagebreak/>
    <mbp:frameset>
      <mbp:pagebreak/>
"""

HTML_CONTENT_AFTER = """      </mbp:frameset>
  </body>
</html>"""

ENTRIES_PER_FILE = 100


def write_content_html(number: int, lines: list[str]):
    with open(f'output/content{number}.html', 'w') as f:
        f.write(HTML_CONTENT_BEFORE)
        f.writelines(lines)
        f.write(HTML_CONTENT_AFTER)

def main():    
    with open('./output/vortaro.html', 'r') as infile:
        n_entry = 0
        n_file = 0
        buffer = []
        for line in infile.readlines():
            if "<h1>" in line:
                n_entry += 1
                if n_entry >= ENTRIES_PER_FILE:
                    print(f'output/content{n_file}.html')
                    write_content_html(n_file, buffer)
                    n_file += 1
                    n_entry = 0
                    buffer = [line]
                else:
                    buffer.append(line)
            else:
                buffer.append(line)
        write_content_html(n_file, buffer)


if __name__ == "__main__":
    main()