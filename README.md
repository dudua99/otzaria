# Otzaria library names — v40

Extracted from Otzaria/SeforimLibrary release `v40-20261123094345` (seforim-schema7.db; archive sha256 39a2b52129323ea53ac3629835c4721e25acff010a8fc971bf076a666a3b9587, verified).

Files: books.tsv (8259 rows), authors.tsv (7400 rows), categories.tsv (1442 rows), summary.txt (books per source; 521 distinct title prefixes before ' על ').

books.tsv extra columns matching collective/heTitle/author: collectiveTitleHe, collectiveTitleEn. Line count from book.totalLines. Authors from book_author + author.

## PRAGMA table_info(book)

```
cid|name|type|notnull|dflt_value|pk
0|id|INTEGER|1||1
1|categoryId|INTEGER|1||0
2|sourceId|INTEGER|1||0
3|title|TEXT|1||0
4|heRef|TEXT|0||0
5|heShortDesc|TEXT|0||0
6|heDesc|TEXT|0||0
7|notesContent|TEXT|0||0
8|orderIndex|INTEGER|1|999|0
9|totalLines|INTEGER|1|0|0
10|isBaseBook|INTEGER|1|0|0
11|hasTargumConnection|INTEGER|1|0|0
12|hasReferenceConnection|INTEGER|1|0|0
13|hasSourceConnection|INTEGER|1|0|0
14|hasCommentaryConnection|INTEGER|1|0|0
15|hasOtherConnection|INTEGER|1|0|0
16|hasAltStructures|INTEGER|1|0|0
17|hasTeamim|INTEGER|1|0|0
18|hasNekudot|INTEGER|1|0|0
19|dependenceType|TEXT|0|NULL|0
20|collectiveTitleHe|TEXT|0|NULL|0
21|collectiveTitleEn|TEXT|0|NULL|0
22|contentHash|INTEGER|1|0|0
```

## PRAGMA table_info(source)

```
cid|name|type|notnull|dflt_value|pk
0|id|INTEGER|1||1
1|name|TEXT|1||0
```

## PRAGMA table_info(category)

```
cid|name|type|notnull|dflt_value|pk
0|id|INTEGER|1||1
1|parentId|INTEGER|0||0
2|title|TEXT|1||0
3|level|INTEGER|1|0|0
4|orderIndex|INTEGER|1|999|0
5|heShortDesc|TEXT|0|NULL|0
6|heDesc|TEXT|0|NULL|0
```
