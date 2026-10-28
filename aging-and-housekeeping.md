# Aging and Housekeeping

Left alone, a diary of everywhere you go
would grow forever, and its weakest
entries — the folder you entered once,
in error, two years ago — would keep
their single point forever, eligible to
win a jump whenever their name happened
to match alone. Zoxide's answer is
**aging**: the database carries a total
budget, and when the budget is exceeded,
every entry is made a little poorer
until the poorest fall out entirely.
This chapter shows the mechanism working
at a budget small enough to watch.

## The rule

The budget is `_ZO_MAXAGE`, and its
default is **10000** — not 10000 folders,
but 10000 total rank points summed over
every entry in the database. Each time
an entry is added and the total stands
over the budget, zoxide rescales:

> every rank is multiplied by
> 0.9 × (budget ÷ total), and any entry
> whose rank falls below 1 is deleted.

The 0.9 matters: after aging, the total
sits at nine-tenths of the budget, so
the next visit does not immediately
trigger another round. Aging is checked
when entries are added — which, thanks
to the hook, is effectively whenever you
change directory.

## Watching it happen

A budget of 10000 makes aging nearly
invisible in real life, so the lab set
`_ZO_MAXAGE=10` against a fresh database
and drove it with `zoxide add --score`
(transcript
`zoxide-lab/transcripts/t06-aging.txt`).
Scores below are ranks × 4, the
within-the-hour multiplier of chapter 6:

```text
$ zoxide add ~/garden --score 8
$ zoxide add ~/workshop --score 5
# total rank 13, over budget: ranks scaled by 0.9 x 10/13
  22.2 .../home/garden        (rank 5.5)
  13.8 .../home/workshop      (rank 3.5)

$ zoxide add ~/documents/letters --score 4
# total settles at rank 9.0 — 0.9 x the budget
  15.3 .../home/garden        (rank 3.8)
   9.6 .../home/workshop      (rank 2.4)
  11.1 .../home/documents/letters   (rank 2.8)
```

Then thirteen one-point adds of a single
folder kept re-triggering the scaling,
and the two weakest entries fell below
rank 1 and were **deleted**:

```text
$ zoxide query --all --score workshop
zoxide: no match found
$ zoxide query --all --score letters
zoxide: no match found
```

Gone — not hidden, not demoted: removed
from the database, as un-findable as if
never visited. At the real default
budget the same law applies with a
slower hand: a folder visited once is
safe until your lifetime total passes
10000 points, and after that it survives
only while its share of the scaling
keeps it at rank 1 or better. In
practice, aging is why a folder from an
abandoned project eventually stops
answering to its name even if you never
formally removed it.

## Moving the diary to a new machine

The database is one file, `db.zo`, in
the data directory (chapter 2), and
moving it is copying it:

1. On the old machine, note the data
   directory — `~/.local/share/zoxide/`
   unless `_ZO_DATA_DIR` says otherwise.
2. Copy `db.zo` to the same place on the
   new machine, *before* zoxide there
   builds a diary of its own worth
   keeping — a copy replaces, it does
   not merge.
3. Entries whose folders do not exist on
   the new machine simply never match
   (chapter 7's dead entries), so a
   diary carried between differently
   organised machines does no harm
   beyond a little dead weight.

And the chapter 1 point, at exactly the
moment it belongs: the file you are
copying is the map of where you work.
Copy it to your own new machine; do not
leave copies on shared drives, in dotfile
repositories, or anywhere public, any
more than you would your shell history.

## Importing an older tool's memory

Arriving from chapter 12's neighbours,
you need not start empty: `zoxide import`
understands the data files of **autojump,
fasd, z, z.lua, zsh-z and atuin**, each
as its own subcommand reading that
tool's customary file. The lab verified
the `z` route — indeed it is how chapter
6's age experiment was built: a file in
z's plain format, one `path|rank|time`
line per folder, placed at `~/.z`, and

```text
$ zoxide import z
```

brought all four entries across with
their ranks and last-visit times intact,
which the decay measurements then read.
The other five importers are the same
idea per tool and are documented rather
than demonstrated here; `--merge` folds
an import into an existing diary instead
of starting from the imported one.
