# Simulate the main-branch --fix run with a stand-in for the live Sefaria title list:
# every title upstream/main's ForDB references that offline mode can't find (main's real CI
# accepts them with live Sefaria) + the source titles of the new book_renames rows.
import sys, re, os, csv, ast
scripts, mainlog, mainrenames, branchrenames = sys.argv[1:5]
sys.argv = [sys.argv[0]] + sys.argv[5:]
sys.path.insert(0, scripts)
os.environ["SEFARIA_FETCH"] = "1"
import validate_fordb_book_names as v
titles = set()
for line in open(mainlog, encoding="utf-8"):
    m = re.match(r"\s*- (?:שורה|רשומה) \d+(?: \([^)]*\))?: ('(?:[^'\\]|\\.)*'|\"(?:[^\"\\]|\\.)*\")", line)
    if m: titles.add(ast.literal_eval(m.group(1)))
old = set(map(tuple, csv.reader(open(mainrenames, encoding="utf-8"))))
for r in csv.reader(open(branchrenames, encoding="utf-8")):
    if r and tuple(r) not in old: titles.add(r[0])
print(f"[sim] stand-in Sefaria list: {len(titles)} titles", flush=True)
v.fetch_sefaria_titles = lambda: set(titles)
sys.exit(v.main())
