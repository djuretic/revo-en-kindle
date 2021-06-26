import sys
from bs4 import BeautifulSoup

# from https://github.com/coljac/kindle_eo_eng/blob/master/src/inflect.py
def inflect(key):
    # ekz: blankkola maraglo
    if ' ' in key:
        return []

    root = key[:-1]
    if key.endswith("o"):
        return [root + x for x in ["on", "oj", "ojn"]]
    elif key.endswith("a"):
        return [root + x for x in ["aj", "an", "ajn"]]
    elif key.endswith("e"):
        return [root + "en"]
    elif key.endswith("i"):
        return [root + x for x in ["as", "os", "is", "us", "u", 
            "ita", "ata", "ota", 
            "inta", "anta", "onta", 
            "intan", "antan", "ontan", 
            "intaj", "antaj", "ontaj", 
            "intajn", "antajn", "ontajn"]]
    else:
        return []

def main(path: str, output_path: str):
    with open(path) as f:
        soup = BeautifulSoup(f, 'html.parser')
    
    entries = soup.find_all('idx:orth')
    for tag in entries:
        tag['value'] = tag['value'].strip().strip(',')
        inflections = inflect(tag['value'])
        if inflections:
            inflection_tag = soup.new_tag("idx:infl")
            for inflection in inflections:
                new_tag = soup.new_tag("idx:iform", attrs={'value': inflection})
                inflection_tag.append(new_tag)
            tag.append(inflection_tag)

    with open(output_path, 'w') as f:
        f.write(str(soup))

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])