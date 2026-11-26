# Run validate_fordb_book_names.py with the live Sefaria index replaced by the pinned
# Sefaria export's table_of_contents.json (SefariaExport release 2026-11-23_10-32-45139177019-1,
# the export v40 was built from; sha256 05f7d137...59fe per the export manifest.txt).
# The replacement does exactly what fetch_sefaria_titles does after the HTTP call.
# usage: python3 run_with_toc.py <scripts-dir> <table_of_contents.json> [validator args...]
import sys, os, json
scripts, toc = sys.argv[1:3]
sys.argv = [os.path.join(scripts, "validate_fordb_book_names.py")] + sys.argv[3:]
sys.path.insert(0, scripts)
os.environ["SEFARIA_FETCH"] = "1"
import validate_fordb_book_names as v
data = json.load(open(toc, encoding="utf-8"))
def fetch():
    v._SEFARIA_DISPLAY_RENAMES.clear()
    v._SEFARIA_DISPLAY_RENAMES.update(v.index_display_renames(data))
    return v.index_titles(data)
v.fetch_sefaria_titles = fetch
print(f"[toc] Sefaria index from pinned export table_of_contents.json: {len(fetch())} titles", flush=True)
sys.exit(v.main())
