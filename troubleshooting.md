# Troubleshooting

Each entry below is a symptom the lab
either produced on purpose or can be
produced at will, with the cause named
by part (chapter 2) and the check that
separates it from its lookalikes. The
transcript for the first two is
`zoxide-lab/transcripts/t90-traps.txt`.

## "z: command not found"

```text
lab$ z web
bash: z: command not found
```

The binary is installed and working —
the lab confirmed `command -v zoxide`
finds it in the very same shell — but
`z` is a *shell function*, and functions
exist only where the init code ran.
Causes, in order of likelihood: the init
line is missing from your startup file;
it is there but this shell predates it
(open a new terminal, or `source` the
file); or you are in a shell you never
set up — a different shell entirely, a
root shell, another machine. The doctor
of chapter 2 covers the subtler cousin:
the line is present but not at the
*end* of the file, and something loaded
after it took the hook apart, in which
case `z` exists but the warning appears
and nothing is learned. Move the line
to the bottom; it is the last word the
file should say.

## Visits that are never learned

You `cd` somewhere daily and `z` still
knows nothing of it. Check what kind of
visiting it is:

- **Scripts don't teach.** The hook
  lives in interactive shells; a folder
  visited only inside `bash -c 'cd
  ~/attic'` was never recorded — the
  lab ran exactly that visit and
  `zoxide query --all attic` still
  answered *no match found*. If a folder
  matters, visit it interactively once,
  or `zoxide add` it (chapter 7).
- **The exclude list got there first.**
  A broad `_ZO_EXCLUDE_DIRS` pattern
  (chapter 9) silently swallows every
  match beneath it — the lab's workshop
  was unlearnable for exactly this
  reason, and learnable again the
  moment the variable was unset. When a
  folder won't stick, check the variable
  before suspecting the database.
- **The hook isn't running** — see the
  doctor, above.

## The jump lands in the wrong twin

Two folders, one name, and `z` keeps
choosing the other one. This is rarely
a malfunction: print the scores and the
choice will explain itself —

```text
$ zoxide query --list --score photos
  24.0 /home/.../home/camera/photos
   8.0 /home/.../home/phone/photos
```

— the winner is ahead on visits, or on
freshness, or both (chapter 6). Then
choose your remedy from chapter 10:
out-visit the right one, pick with `zi`
for today's jump, or `zoxide remove`
the stale entry. What the scores give
you is the end of superstition: there
is never a mystery landing, only an
unread sum.

## "no match found" for a folder that plainly exists

It exists on disk; the question is
whether it exists in the *diary*.
`zoxide query --all <name>` separates
the cases:

- **Not there even with `--all`** — it
  was never recorded (first section of
  chapter 13), or it was aged out
  (chapter 11). Visit it, or add it.
- **There with `--all`, absent without**
  — the folder has been deleted or
  renamed on disk, and default queries
  are skipping its ghost (chapter 7).
  Remove the entry, and re-add the
  folder at its new name by visiting it.

## "could not find fzf" from zi or edit

```text
zoxide: could not find fzf, is it installed?
```

The picker and the database editor are
the two fzf clients (chapters 7 and 8);
the rest of zoxide neither needs nor
misses fzf. Install it (chapter 3's
closing section), in a place on the
PATH of the shell you actually use —
a fzf installed into one environment
and a zoxide used from another is the
usual shape of this error persisting
after an "install".

## The database seems to forget between terminals

If one terminal knows your folders and
another doesn't, they are almost
certainly reading different databases:
`_ZO_DATA_DIR` set in one environment
and not the other (a terminal launched
from a desktop session versus one from
SSH is the classic pair). Compare
`echo $_ZO_DATA_DIR` in both, and
remember the default is
`~/.local/share/zoxide/` — a variable
set to a slightly wrong path creates a
second, younger diary that learns in
parallel and explains every "it knew
this yesterday" haunting.
