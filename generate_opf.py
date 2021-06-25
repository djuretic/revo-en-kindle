from pathlib import Path

def main():
    with open('template.opf') as f:
        lines = f.readlines()
    
    html_dir = Path('./output')
    html_files = list(html_dir.glob("content*.html"))
    html_files.sort()

    n = 0

    with open("./output/vortaro.opf", "w") as f:
        for line in lines:
            if "<item id" in line:
                for n, html in enumerate(html_files):
                    # TODO test media-type="application/xhtml+xml"
                    f.write(f"""    <item id="dictionary{n}" href="{html.name}" media-type="text/x-oeb1-document"/>\n""")
            elif "<itemref" in line:
                # the previous loop will set "n"
                for n in range(n + 1):
                    f.write(f"""         <itemref idref="dictionary{n}"/>\n""")
            else:
                f.write(line)


if __name__ == "__main__":
    main()