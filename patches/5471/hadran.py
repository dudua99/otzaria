import glob, os, sys
root = sys.argv[1]
d = os.path.join(root, 'ToratEmetToOtzaria/ספרים/אוצריא/תלמוד בבלי/ספרות עזר/ביאור חברותא')
tsv = os.path.join(root, 'ToratEmetToOtzaria/post_convert_fixes.tsv')
NOTE = '#5471 ההדרן צמוד לפרק שהסתיים; הרווח (<br>) עובר מלפני ההדרן אל אחריו'
def esc(s): return s.replace('\\', '\\\\').replace('\t', '\\t').replace('\n', '\\n')
rows = []; tsv_text = open(tsv, encoding='utf-8', newline='').read()
stats = {'books': 0, 'lines': 0, 'closing_pairs': 0}
for path in sorted(glob.glob(os.path.join(d, 'חברותא על *.txt'))):
    book = os.path.basename(path)[:-4]
    text = open(path, encoding='utf-8', newline='').read()
    L = text.split('\n'); N = list(L); n0 = len(L); touched = False
    for i, l in enumerate(L):
        if not l.startswith('<br><center><big><b>הדרן'):
            continue
        touched = True; stats['lines'] += 1
        nxt = L[i+1] if i + 1 < len(L) else None
        if nxt is not None and nxt.startswith('<center>'):
            # hadran + "וסליקא מסכת" closing pair: keep both together, gap after the pair.
            N[i] = l[4:]; N[i+1] = nxt + '<br>'; stats['closing_pairs'] += 1
            old_new = esc(l + '\n' + nxt); new_new = esc(N[i] + '\n' + N[i+1])
            # existing row (545-549) whose `new` is exactly this pair: retarget it
            cnt = tsv_text.count('\t' + old_new + '\t')
            assert cnt == 1, (book, cnt)
            tsv_text = tsv_text.replace('\t' + old_new + '\t', '\t' + new_new + '\t')
            continue
        N[i] = l[4:] + '<br>'
        if text.count(l) == 1:
            old, new = l, N[i]
        elif nxt is not None and text.count(l + '\n' + nxt) == 1:
            old, new = l + '\n' + nxt, N[i] + '\n' + nxt
        else:
            prv = L[i-1]; assert text.count(prv + '\n' + l) == 1, (book, i)
            old, new = prv + '\n' + l, prv + '\n' + N[i]
        rows.append('\t'.join([book, esc(old), esc(new), NOTE]))
    if touched:
        stats['books'] += 1
        assert len(N) == n0
        open(path, 'w', encoding='utf-8', newline='').write('\n'.join(N))
if not tsv_text.endswith('\n'): tsv_text += '\n'
tsv_text += '\n'.join(rows) + '\n'
open(tsv, 'w', encoding='utf-8', newline='').write(tsv_text)
print(stats, 'new rows', len(rows))
