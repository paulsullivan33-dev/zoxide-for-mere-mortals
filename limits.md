# Limits

Zoxide is a small tool with a short list
of things it cannot do — but they are
load-bearing limits, in that nearly
every disappointment a user ever has
with it is one of these five, arriving
unannounced. Here they are announced.

## It only knows where you have been

The database is the whole world
(chapter 5, rule 0). A folder you have
never visited — newly created, newly
cloned, on a disk you just mounted —
does not merely rank low; it does not
exist to the matcher, and the answer is
`zoxide: no match found` no matter how
exactly you name it. The lab's
`website-old` sat on disk, matching
`web` perfectly, unseen, for the whole
investigation. The remedies are the
visit itself, or `zoxide add` — and the
deeper acceptance that zoxide is a
memory, and memories start empty, per
machine, per account, per data
directory. Chapter 12's disk search is
the tool for folders outside your
history.

## It follows habits, not intentions

Frecency is a count of the past
(chapter 6). It cannot know that the
project ended, that you have moved
teams, that *this* time `photos` means
the other one. The consequences are
mild — a wrong landing, a moment's
correction by chapter 10's recipes —
but they are permanent features, not
bugs awaiting fixes: the tool's entire
value is that it believes your feet,
and feet are historians, not prophets.
Where the distinction matters at the
moment of jumping, the picker (chapter
8) exists precisely to let today's
intention overrule the accumulated past
for one jump.

## The diary is a real record

Chapter 1 stated it and here it is
again, as a limit on where the tool can
go: the database enumerates the folders
you use, with counts and times. It
reveals the shape of your work to
anyone who can read your home folder —
employer machines, shared machines and
backups all carry it. It has no
encryption, no redaction, and no notion
of a folder too private to remember;
the only controls are the exclude list
of chapter 9 (before the fact) and
`remove` (after it). On a machine where
that record itself is a problem,
zoxide is the wrong tool, and chapter
12's stateless alternatives — CDPATH,
aliases, disk search — remember nothing
at all.

## The database is one file, with no sync

There is no zoxide server, no account,
no merging protocol. Two machines have
two diaries; carrying one to the other
is the manual copy of chapter 11, and
it replaces rather than merges (the
importers are for *other tools'*
memories, and `--merge` is for one-off
arrivals, not a standing synchronisation).
Folders whose paths differ between
machines make a carried diary partly
dead weight — harmless, but the ranking
you import is only as portable as your
directory layout is uniform. Readers
who keep identical layouts everywhere
will feel this limit least; readers who
don't will feel it immediately.

## It is a shell convenience, not a system service

`z` exists only where the init line ran:
interactive shells of the users who
installed it. Programs you launch cannot
`z`; system scripts and cron jobs see
nothing of it; a folder visited only by
a script's private `cd` is never learned
(chapter 14 demonstrates exactly that).
The query command is available to any
process (chapter 10's script recipe is
the supported bridge), but the *learning*
is tied to your interactive life. And
everything zoxide knows is folders: not
files, not commands, not the folder you
meant inside the archive you downloaded.
Small tool, small world — kept honest,
this chapter hopes, by being told so.
