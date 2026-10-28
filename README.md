# Zoxide for Mere Mortals

Changing directory is the most ordinary
thing you do in a terminal, and the most
wasteful: `cd` asks you to remember and
retype the full path of every folder you
use, every time, as if you had never been
there before. **Zoxide** is a smarter
`cd` command. It watches where you go,
remembers the folders you actually use,
and afterwards takes you back with a few
letters: `z web` instead of
`cd ~/projects/website`. It ranks your
folders by **frecency** — how often and
how recently you visit them — so the
folder you mean is usually the folder it
picks, even when several folders share a
name.

This guide explains how that memory
works, how to teach it your first
folders, the rules its matching follows,
how the ranking is arithmetic rather
than magic, and how to ask the database
questions directly, retrain it, and prune
it. The limits are stated plainly,
including the one everything else follows
from: zoxide only knows the folders you
have already visited. A folder you have
never entered does not exist as far as it
is concerned.

One point is made in chapter 1 and
repeated in chapter 13, because it is
easy to forget: **zoxide's database is a
diary of every folder you visit**, kept
in a small file in your home folder. It
is yours, on your own machine, and as
private as your shell history — which is
what it resembles. Think before you copy
it anywhere, sync it, or hand it to
anyone, because it maps out where you
spend your time on that machine.

The lab behind this guide ran the real
thing: **zoxide 0.10.0**, the official
release binary, hooked into a real
interactive **bash 5.2** with its own
scratch home folder and a practice tree
of ordinary folders (a couple of project
folders, documents, two rival folders
both named `photos`). Against that tree
the lab learned folders by visiting them,
jumped by partial names and by keywords
in order — and in the wrong order, which
fails — staged a contest between the two
`photos` folders and watched the
oft-visited one win, read the database's
scores directly, added and removed
entries by hand, measured the way scores
decay with age by importing entries of
known ages, drove the database's aging
with a tiny budget until weak entries
were deleted, and picked a folder out of
the interactive list with a real **fzf
0.74.5** standing behind it.

What the lab could not do, it did not
fake. It worked in one shell, bash, so
the setup for zsh, fish, PowerShell and
the other supported shells is taught from
the project's documentation and labelled
as such wherever it appears. The
interactive database editor's keystrokes
are likewise described rather than
demonstrated: it is a full-screen
interface, and full-screen interfaces
leave no transcript to keep.
`criteria.md` keeps the full ledger of
what was run and what was only read.

## What this guide covers

- [**What zoxide is**](what-zoxide-is.md) —
  the memory test that `cd` sets you, the
  diary zoxide keeps instead, and the
  privacy point that comes with keeping it
- [**The moving parts**](the-moving-parts.md) —
  the binary, the shell hook, the database
  file, and the query that answers when
  you type `z`
- [**Installing zoxide**](installing-zoxide.md) —
  the release binary and the package
  routes, the one line in your shell's
  startup file, and why it belongs at
  the end
- [**Your first jump**](your-first-jump.md) —
  visiting folders so the hook learns
  them, then jumping back with a few
  letters
- [**How matching works**](how-matching-works.md) —
  keywords as fragments, why their order
  matters, why the last one must match
  the folder's own name, and the folders
  zoxide cannot see
- [**Frecency and rank**](frecency-and-rank.md) —
  the score arithmetic: a rank for every
  visit, a multiplier for how long ago,
  and a staged contest between two
  folders with the same name
- [**Asking directly**](asking-directly.md) —
  `zoxide query`, `add` and `remove`:
  reading the memory, correcting it, and
  the entries it keeps for folders that
  no longer exist
- [**The interactive picker**](the-interactive-picker.md) —
  `zi` and fzf: choosing from the list
  with your eyes when the ranking picks
  the wrong twin
- [**Making it yours**](making-it-yours.md) —
  the environment variables, the init
  options, and replacing `cd` itself if
  you want to
- [**Recipes**](recipes.md) — jump and
  work, shuttle between two folders,
  ask from inside a script, and retrain
  a jump that keeps landing wrong
- [**Aging and housekeeping**](aging-and-housekeeping.md) —
  the total-rank budget that quietly
  forgets your weakest folders, moving
  the database to a new machine, and
  importing an older tool's memory
- [**The neighbours**](the-neighbours.md) —
  autojump, the z family, fasd, fzf's own
  directory search, and the shell's
  built-in tricks: what each remembers
  that zoxide doesn't, and vice versa
- [**Limits**](limits.md) — folders it
  has never seen, a memory that starts
  empty, habits mistaken for intentions,
  and the diary itself, stated plainly
- [**Troubleshooting**](troubleshooting.md) —
  the missing `z`, the folder that never
  gets learned, the jump that lands in
  the wrong twin, and the picker that
  cannot find fzf
- [**Glossary**](glossary.md) — the
  terms, collected in one place

## What it doesn't cover

Finding files, or folders, anywhere on
the disk: zoxide is a memory, not a
search, and a guide in this series
(*Finding Files for Mere Mortals*) covers
searching the filesystem itself. Shell
scripting in general, and the other
shells' setup beyond the one line each
needs, are pointed at rather than taught.
Synchronising the database between
machines is deliberately manual in
zoxide, and this guide describes carrying
it rather than automating it: chapter 11
explains why a copied diary deserves a
thought first anyway.

## How to use this guide

Read chapter 1 for the model and the
privacy point, and chapter 2 before
installing anything — knowing which part
remembers and which part jumps turns
later confusion into a named problem.
Chapters 3 and 4 belong in the same
sitting: install, add the one line, then
visit a few folders and jump back. Do
not judge the tool in the first minute,
when its memory is empty; judge it after
a day of ordinary work, which is when
the ranking becomes yours. Chapter 6 is
the one to read slowly — once the score
arithmetic makes sense, every surprise
zoxide ever gives you is a sum you can
check. The lab's transcripts live in
`zoxide-lab/transcripts/`; the script
that builds its practice tree is
`zoxide-lab/make-fixture.sh`; its notes
are `examples/lab-notes.txt`.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [Bash for Mere Mortals](https://paulsullivan33-dev.github.io/bash-for-mere-mortals/)
- [Finding Files for Mere Mortals](https://paulsullivan33-dev.github.io/finding-files-for-mere-mortals/)
- [fzf for Mere Mortals](https://paulsullivan33-dev.github.io/fzf-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/zoxide-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/zoxide-for-mere-mortals/blob/main/LICENSE-CODE).
