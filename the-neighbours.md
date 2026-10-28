# The Neighbours

Zoxide stands in a long, honourable
line of tools that all began from the
same irritation, and its own importer
(chapter 11) is an admission of ancestry.
This chapter characterises the family
and the near neighbours — who remembers
what, and how — without benchmarking
any of them: the right choice among
these is a matter of which memory model
suits your habits, not of speed.

## The ancestors

**autojump** (Python, from 2009) is the
one that popularised the idea: it keeps
a weighted database of your folders and
answers to `j`. It is the direct ancestor
of nearly everything below, zoxide
included — the frecency blend of chapter
6 is its inheritance, refined. It needs
its Python runtime and moves at a human
pace; its data file is plain text.

**z** (a shell script, by rupa) stripped
the idea to its minimum: one small
script, a plain-text data file at `~/.z`
(one `path|rank|time` line per folder —
the very format chapter 11 imports),
and a ranking by the same frecency
idea. Ported and re-grown several times:
**zsh-z** and **z.lua** are its best-known
descendants, the latter adding its own
matching modes. If you like your tools
auditable at a glance, z's descendants
are the ones whose memory you can read
in a text editor — the property zoxide
0.10 gave up (chapter 2).

**fasd** widened the question: it
remembers *files* as well as folders,
and offers its recent-and-frequent lists
to other programs as arguments, not just
as destinations. If your repeated
journeys more often end at a *file* —
the same document, the same log — fasd's
memory fits better than any folder-only
tool's, zoxide's included.

## The different answer: don't remember, search

**fzf's own directory widgets** (the
Alt-C binding of the *fzf* shell
integration) take the opposite position:
no memory at all. The list is walked
from the disk as you type, so it can
offer folders you have never visited —
the exact case where zoxide must answer
*no match found*. The two compose
happily: zoxide for the ninety journeys
you repeat, fzf's search for the one
into unknown country, and chapter 8's
`zi` sits between them, a memory with a
search-like face. *Finding Files for
Mere Mortals* covers the disk-searching
side of the family properly.

## The shell's own memory

Your shell is not without tricks of its
own, and for light needs they may be
enough:

- **`cd -`** and `$OLDPWD` — one folder
  back, no memory beyond that.
- **`pushd` / `popd` / `dirs`** — a stack
  you maintain by hand: explicit, exact,
  and gone when the shell exits.
- **`CDPATH`** — a search path for `cd`
  itself: if `projects` is in your
  `CDPATH`, then `cd website` finds
  `~/projects/website` from anywhere.
  Static where zoxide is learned, but
  predictable in a way a ranking is not.
- **aliases** for the two or three
  journeys you make constantly —
  `alias web='cd ~/projects/website'` —
  zero machinery, and the honest answer
  if your world really is three folders.

## The verdict-shaped summary

All of these, zoxide included, are the
same bargain at different prices: a
little machinery and a little trust in
your own habits, against a lifetime of
retyping paths. Zoxide's particular
offer is the learned ranking, the
keyword matching of chapter 5, and
speed enough that the answering is
invisible — in exchange for a binary
database you inspect through the tool
rather than with your eyes. If being
able to *read* the memory matters more
to you, z's family keeps it in plain
text; if the memory should cover files
too, fasd is waiting; and if you try
zoxide and leave, chapter 11's importers
run in the other tools' directions far
less often than into zoxide — which is
its own small comment on where the
family's centre of gravity now sits.
