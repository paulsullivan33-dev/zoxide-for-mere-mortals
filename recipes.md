# Recipes

Small, whole jobs, each using what the
earlier chapters verified. The folder
names are the lab's; yours will differ,
and nothing here depends on the names.

## Jump, then work

The everyday shape of zoxide: the jump
is the first half of a sentence.

```bash
z web && git status
z inv && ls -la
z api && ./run-the-tests.sh
```

Chain with `&&` and the second command
runs only if the jump landed — chapter 7
taught that a failed jump is a real
failure with an exit code, and `z`
inherits it, so a mis-typed keyword
stops the line instead of running the
command in the wrong folder.

## Shuttle between two folders

Copying or comparing between two places
is a two-folder dance, and `z -` is the
shuttle (chapter 4):

```bash
z web
cp ~/documents/invoices/totals.txt .
z -
```

`z -` returns you to the folder you
jumped from, each time, so a sequence of
`z -` steps paces back and forth between
the same pair for as long as the job
takes. It is the previous-directory
memory of `cd -`, with the rest of
zoxide attached when you need it.

## Ask from inside a script

`z` is a function of interactive shells;
scripts do not have it, and do not need
it, because chapter 7's `zoxide query`
is an ordinary command that prints an
ordinary path:

```bash
#!/bin/sh
cd "$(zoxide query web)" || exit 1
./build.sh
```

The script lands where your interactive
self would have landed, because it is
reading the same diary — one more reason
the diary's habits are worth keeping
honest. Guard the `cd` as shown: if the
query finds nothing it exits 1, and the
script should stop rather than build in
whatever folder it happened to start in.

## Retrain a jump that lands wrong

The jump keeps taking you to a folder
from a finished project. Three fixes, in
order of how much they change:

1. **Out-visit it.** The ranking is a
   count; work in the right folder for a
   day and the count — helped by the
   recency multiplier of chapter 6 —
   rights itself. This is the fix that
   keeps the tool's promise that your
   feet do the teaching.
2. **Pick instead, today.** `zi` with
   the same keywords (chapter 8) lets
   you choose the other twin for this
   one jump, leaving the record as is.
3. **Remove the stale entry.** `zoxide
   remove <folder>` (chapter 7) ends the
   argument immediately, at the price of
   forgetting the folder entirely; it
   will be relearned if you ever go back.

What not to do: rename your folders to
please the matcher. The matcher serves
the folders, not the other way round.

## Start a new machine with a head start

On a fresh machine the diary is empty
(chapter 13), but you know your first
three folders already. Teach them in one
line each (chapter 7) and let habit do
the rest:

```bash
zoxide add ~/projects/website ~/documents/invoices ~/garden
```

`zoxide add` takes several paths at
once. Or carry the old machine's diary
over wholesale — chapter 11 covers the
carrying, and the thought to have before
doing it.
