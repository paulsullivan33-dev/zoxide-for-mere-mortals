# Asking Directly

`z` is the database questioned in a
hurry, on its way somewhere. The
`zoxide` command itself questions it in
the open — and because those questions
work in any shell, script, or pipeline,
this is also the chapter that makes
zoxide useful outside your interactive
terminal. Everything here was run
against the lab's real database;
transcript `zoxide-lab/transcripts/t04-query-add-remove.txt`
holds most of it.

## query: the question z asks

```text
$ zoxide query --score web
  12.0 /home/.../home/projects/website
```

`zoxide query` takes the same keywords
`z` takes, applies the same matching
rules (chapter 5) and the same frecency
choice (chapter 6), and *prints* the
winning path instead of travelling to
it. Its decorations are the useful part:

- `--list` prints **every** match,
  best first, instead of only the winner.
- `--score` prints each result's score
  beside it — the arithmetic of chapter
  6, on demand. Whenever a jump surprises
  you, this is the first thing to run.
- `--all` includes entries whose folders
  **no longer exist** on disk, which the
  next section is about.
- `--exclude <path>` ignores one folder;
  the `z` function uses it to exclude
  the folder you are standing in, which
  is where chapter 5's *"you are already
  in the only match"* message comes from.

And when nothing matches, the failure is
plain and scriptable:

```text
$ zoxide query zzz-no-such-place
zoxide: no match found
exit=1
```

Message on the error stream, exit code
1: a script can test it, and so can you.

## add: teaching by hand

The hook teaches zoxide the folders you
visit. `zoxide add` teaches it the ones
you name, and tops up ranks deliberately:

```text
$ zoxide add ~/garden --score 5
$ zoxide query --score garden
  24.0 /home/.../home/garden
```

`garden` had been visited once (rank 1);
the add gave it five more, and 6 × 4
makes the 24.0 shown. Plain `zoxide add
<folder>` adds the usual single point.
This is the tool for seeding a new
machine with the three folders you know
you will live in, and — used in reverse
below — for understanding that the
database takes your word for things:
it does not check that a folder is
*important*, only that it exists.

## remove: correcting the record

```text
$ zoxide remove ~/phone/photos
$ zoxide query --list --score photos
  28.0 /home/.../home/camera/photos
```

`zoxide remove` deletes an entry
outright — the answer when the ranking
has learned something you would rather
it hadn't, or when a folder is gone for
good. The remaining match stands alone
afterwards, as the transcript shows.

## The folders that are no longer there

Folders die — projects end, disks are
reorganised — and the database does not
find out on its own. The lab made a
folder, added it, and deleted it from
the disk:

```text
$ zoxide query ephemeral
zoxide: no match found
$ zoxide query --all ephemeral
/home/.../home/ephemeral
```

Default queries quietly skip entries
whose folders have vanished — so a dead
folder can never swallow a jump — but
nothing has been deleted: `--all` shows
the entry still sitting in the diary.
It stays there until you `zoxide remove`
it, or until the aging of chapter 11
wears its rank away. Knowing this
explains the one otherwise-puzzling
sight in this area: a `--list --all`
longer than the list of folders you
actually have.

## edit: the interactive ledger

`zoxide edit` opens the whole database
in a full-screen, fzf-driven editor
where entries can be inspected, boosted
and deleted interactively. It needs fzf
installed — without it, the lab
captured its refusal (`zoxide: could not
find fzf, is it installed?`, the same
message as chapter 8's). Because it is
a full-screen interface it leaves no
transcript to keep in this guide's lab,
so its keystrokes are described from the
project's documentation rather than
demonstrated; the operations it performs
are the same `add` and `remove` taught
above, wearing a friendlier face.
