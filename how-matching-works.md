# How Matching Works

When you type `z` and some words, zoxide
must decide which of the folders in its
database — if any — you mean. The
decision is two steps: first a *match*
test that keeps the folders your words
could describe, then the frecency
ranking of chapter 6 to choose among the
survivors. This chapter is the match
test. Every rule below was put to the
lab's real database, and the transcript
is `zoxide-lab/transcripts/t02-first-jumps.txt`
unless another is named.

## Rule 1: a keyword is a fragment

A keyword does not have to be the whole
of anything. It has to appear *inside*
the path:

```text
lab$ z oice
```

landed in `~/documents/invoices` —
`oice` is a fragment of the folder's
name, and fragments are enough. (The
same command, typed while already
standing in `invoices`, produced the
polite refusal `zoxide: you are already
in the only match` — `z` excludes the
folder you are standing in, and says so
when that was the only candidate.)

## Rule 2: the last keyword names the folder itself

Apart from the last one, keywords may
match anywhere in the path. The **last**
keyword must match inside the final
component — the folder's own name. That
single rule is what makes `z web` mean
"a folder called something-like-web"
rather than "anything under a web-ish
parent", and it is why the lab's query
(transcript `t04-query-add-remove.txt`)

```text
$ zoxide query --list --score proj
   4.0 /home/.../home/projects
```

listed only the `projects` folder
itself: `projects/website` and
`projects/api` contain `proj` in a
parent, but their own names do not.

## Rule 3: keywords must appear in path order

Give several keywords and they are a
little itinerary: each must be found in
the path, in the order you typed them.

```text
lab$ z proj api      ->  ~/projects/api
lab$ z api proj      ->  zoxide: no match found
lab$ z doc inv       ->  ~/documents/invoices
lab$ z inv doc       ->  zoxide: no match found
```

This is the rule that makes two-keyword
jumps so precise: `doc inv` describes a
path where something doc-like comes
before something inv-like, and in a
grown-up database that usually describes
exactly one folder you own.

## Rule 4: capitals make no difference

The lab typed `z WEB` and arrived in
`website`. Matching in this version is
case-insensitive, full stop — there is
no separate rule to learn for keywords
shouted in capitals.

## Rule 5: a real path beats the database

Give `z` one argument that already names
a real folder — relative to where you
stand, or absolute — and it simply goes
there, no database involved:

```text
lab$ z projects        (standing at home)
lab$ z ~/garden
```

This is why `z` can wholly replace `cd`
in your fingers if you let it (chapter 9
shows making that official): anything
`cd` could have taken literally, `z`
takes literally, and everything else it
treats as keywords.

## Rule 0: the database is the whole world

Underneath all five rules sits the one
from chapter 1. The lab's `projects`
folder contained `api`, `website` and
`website-old` — but:

```text
lab$ ls ~/projects
api  website  website-old
lab$ zoxide query --list web
/home/.../home/projects/website
```

`website-old` exists. It matches `web`
perfectly. And it is invisible, because
nobody had ever visited it, so it is not
in the database and no match test ever
sees it. Matching is a test applied to
*memories*, not to the disk. Hold on to
that when a jump fails: the question is
never "does the folder exist?" but "has
the hook ever watched me arrive there?"
