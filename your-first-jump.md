# Your First Jump

This chapter's outcome is small and
complete: a shell that remembers the
folders you show it, and your first three
jumps back into them. There is nothing
to configure and nothing to study —
zoxide learns the way you would want a
dog to learn the neighbourhood, by being
taken there.

The lab's practice tree is a handful of
ordinary folders — a `projects` folder
with three subfolders, a `documents`
folder with two, a garden, a workshop,
and two folders both called `photos`
under different parents. The script that
builds it is `zoxide-lab/make-fixture.sh`,
and the tree is deliberately dull: every
behaviour in this guide shows up at least
as well on folders of your own, and you
are welcome to follow along in your real
home folder instead, where the lesson
arrives pre-installed on your own work.

## Teach it three folders

With the init line in place (chapter 3),
open a fresh terminal and simply go
about a small errand with ordinary `cd`
(transcript `zoxide-lab/transcripts/t01-first-visits.txt`):

```text
lab$ cd projects
lab$ cd website
lab$ cd ~/documents
lab$ cd invoices
lab$ cd ~
lab$ cd garden
lab$ cd ~
```

Nothing answers. Nothing is supposed to:
the hook of chapter 2 does its work
silently at each prompt, and the only
visible trace is the new database file:

```text
lab$ ls -la ~/.local/share/zoxide/
-rw-rw---- 1 root root 459 ... db.zo
```

That is the whole teaching method.
Zoxide has no import-your-life step and
no settings screen of folders to pin;
it trusts your feet. (Chapter 11 does
cover importing an *older tool's* memory,
if you are arriving from one.)

## Jump

Now the same journeys, backwards, with
`z` (transcript `t02-first-jumps.txt`):

```text
lab$ z web
lab$ pwd
/home/.../home/projects/website
lab$ z doc inv
lab$ pwd
/home/.../home/documents/invoices
```

`z web` found the one folder whose name
contains `web`; `z doc inv` used two
fragments — one from a parent folder,
one from the folder itself — and chapter
5 makes those rules precise. Two more
behaviours from the same transcript are
worth noticing now:

```text
lab$ z WEB
lab$ pwd
/home/.../home/projects/website

lab$ z -
lab$ pwd
/home/.../home/documents/invoices
```

The matching does not care about capital
letters, and `z -` goes back to the
folder you just came from, the way
`cd -` does. And with no words at all,
`z` alone goes home, like `cd` alone.

Check: each landing is provable with
`pwd`, which is how every transcript in
this guide proves it. If a jump ever
surprises you, chapter 6's arithmetic —
not faith — is where the answer lives,
and `zoxide query --list --score`
(chapter 7) will show you the scores
that decided it.

## The honest first-hour report

Zoxide in its first hour is a modest
tool, because its world is the three or
four folders it has met. In the lab's
transcript you can watch the world being
exactly that small: `z proj api` fails
with `zoxide: no match found` because
nobody had visited `projects/api` yet —
and succeeds a minute later, after a
single ordinary `cd` there. Nothing is
broken in the failure; the database is
simply the whole of its knowledge,
which is chapter 13's first limit and
this guide's refrain. Use your shell
normally, and the world grows on its own.
